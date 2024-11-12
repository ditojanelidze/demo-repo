# frozen_string_literal: true

class User < ApplicationRecord
  include WorkflowActiverecord
  include Attachable

  acts_as_paranoid
  has_secure_password

  validates :first_name, :last_name, :phone_number, :phone_number_iso, :password_digest, :locale, presence: true
  validates :first_name, length: { maximum: 50 }
  validates :last_name, length: { maximum: 50 }
  validates :phone_number_iso, length: { maximum: 2 }
  validates :password_recovery_token, length: { maximum: 150 }
  validates :password_recovery_code, length: { maximum: 4 }
  validates :password, password_strength: true
  validates :phone_number, phone_number: true, uniqueness: { scope: :workflow_state,
                                                             conditions: lambda {
                                                               where(workflow_state: 'active', deleted_at: nil)
                                                             } }
  validates :locale, length: { maximum: 2 }

  validates_with AvatarValidator

  has_one_attached :avatar

  has_many :active_followings, class_name: 'Following', foreign_key: :follower_id, dependent: :destroy,
                               inverse_of: :followed
  has_many :followed_users, through: :active_followings, source: :followed

  has_many :passive_followings, class_name: 'Following', foreign_key: :followed_id, dependent: :destroy,
                                inverse_of: :follower
  has_many :followers, through: :passive_followings, source: :follower
  has_many :posts, dependent: :destroy

  default_scope { where(workflow_state: :active) }

  workflow do
    state :pending do
      event :active, transitions_to: :active
      event :abandon, transitions_to: :abandoned
    end
    state :active do
      event :suspend, transitions_to: :suspended
      event :delete, transitions_to: :deleted
    end
    state :suspended do
      event :unsuspend, transitions_to: :active
    end
    state :abandoned
    state :deleted
  end

  def following_data
    FollowingsInfo.find_or_initialize_by(user_id: id)
  end

  def following?(other_user)
    followed_users.include?(other_user)
  end

  # Follow another user
  def follow!(other_user)
    followed_users << other_user unless following?(other_user) || self == other_user
  end

  # Unfollow another user
  def unfollow!(other_user)
    followed_users.delete(other_user)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end

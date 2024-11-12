class CreateWaters < ActiveRecord::Migration[8.0]
  def up
    execute "
    CREATE TABLE waters(id BIGSERIAL PRIMARY KEY,
                        ogc_fid VARCHAR NOT NULL,
                        geometry geometry(Geometry, 4326) NOT NULL,
                        osm_id VARCHAR NOT NULL,
                        water_type INTEGER NOT NULL,
                        name VARCHAR NOT NULL,
                        created_at TIMESTAMP NOT NULL DEFAULT NOW(),
                        updated_at TIMESTAMP NOT NULL DEFAULT NOW());"
  end

  def down
    execute " DROP TABLE waters"
  end
end


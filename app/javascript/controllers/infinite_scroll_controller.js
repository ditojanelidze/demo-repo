import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { endpoint: String }

  connect() {
    this.loading = false;
    window.addEventListener('scroll', this.loadMore.bind(this));
  }

  disconnect() {
    window.removeEventListener('scroll', this.loadMore.bind(this));
  }

  loadMore() {
    if (this.loading) return;

    const nearBottom = window.innerHeight + window.scrollY >= document.body.offsetHeight - 500;

    if (nearBottom) {
      this.loading = true;
      this.loadPosts();
    }
  }

  loadPosts() {
    const url = this.endpointValue + `?page=${this.nextPage()}`;
    fetch(url, {
      headers: { 'Accept': 'application/json' },
    })
        .then(response => response.json())
        .then(data => {
          this.appendPosts(data.posts);
          this.loading = false;
        })
        .catch(() => this.loading = false);
  }

  appendPosts(posts) {
    const grid = document.getElementById('posts-grid');
    posts.forEach(post => {
      const postElement = document.createElement('div');
      postElement.innerHTML = post.html;
      grid.appendChild(postElement.firstElementChild);
    });
  }

  nextPage() {
    return document.querySelectorAll('#posts-grid > div').length / 10 + 1;
  }
}

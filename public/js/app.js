// NEXO — app.js (feed principal)
'use strict';

/* ── Theme ── */
function applyTheme(t) {
  document.documentElement.setAttribute('data-theme', t);
  localStorage.setItem('nexo-theme', t);
  const btn = document.getElementById('themeToggleBtn');
  if (btn) btn.innerHTML = t === 'dark' ? '☀️' : '🌙';
}
(function initTheme() {
  const saved = localStorage.getItem('nexo-theme') || 'dark';
  applyTheme(saved);
})();
document.getElementById('themeToggleBtn')?.addEventListener('click', () => {
  const cur = document.documentElement.getAttribute('data-theme');
  applyTheme(cur === 'dark' ? 'light' : 'dark');
});

/* ── Populate selects ── */
function populateSelect(id, items, allLabel) {
  const el = document.getElementById(id);
  if (!el) return;
  el.innerHTML = `<option value="">${allLabel}</option>`;
  items.forEach(it => {
    const o = document.createElement('option');
    o.value = it.id ?? it;
    o.textContent = it.nombre ?? it;
    el.appendChild(o);
  });
}
populateSelect('filterSede',    NEXO.sedes,    'Todas las sedes');
populateSelect('filterCarrera', NEXO.carreras, 'Todas las carreras');

/* ── Badge helper ── */
const TIPO_LABEL = { apunte:'Apunte', duda:'Duda', informacion:'Info', grupo_estudio:'Grupo' };
const TIPO_CLASS = { apunte:'badge-apunte', duda:'badge-duda', informacion:'badge-info', grupo_estudio:'badge-grupo' };

/* ── Render post ── */
function renderPost(p) {
  const tags = p.tags.map(t => `<a class="tag" href="index.html?tag=${encodeURIComponent(t)}">#${t}</a>`).join('');
  const files = p.archivos.map(f =>
    `<a class="file-pill" href="#" title="${f.nombre}">
      <svg width="12" height="12" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/></svg>
      ${f.nombre}
    </a>`
  ).join('');

  const vClass = p.votos >= 0 ? 'positive' : 'negative';
  const upActive   = p.miVoto === 1  ? 'active' : '';
  const downActive = p.miVoto === -1 ? 'active' : '';
  const savedClass = p.guardado ? 'saved' : '';

  return `
  <article class="post-card" data-id="${p.id}">
    <div class="vote-col">
      <button class="vote-btn up ${upActive}" aria-label="Votar positivo" data-id="${p.id}" data-dir="1">
        <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M5 15l7-7 7 7"/></svg>
      </button>
      <span class="vote-count ${vClass}">${p.votos}</span>
      <button class="vote-btn down ${downActive}" aria-label="Votar negativo" data-id="${p.id}" data-dir="-1">
        <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M19 9l-7 7-7-7"/></svg>
      </button>
    </div>
    <div class="post-content">
      <div class="post-meta">
        <a class="post-community" href="comunidad.html?slug=${p.comunidad_slug}">
          <svg width="12" height="12" fill="currentColor" viewBox="0 0 20 20"><path d="M10 2a8 8 0 100 16A8 8 0 0010 2z"/></svg>
          r/${p.comunidad}
        </a>
        <span>•</span>
        <span>publicado por <a href="perfil.html?alias=${p.autor}" class="post-author">u/${p.autor}</a></span>
        <span>•</span>
        <span>${p.hace}</span>
        ${p.materia ? `<span>•</span><span>${p.materia}</span>` : ''}
      </div>
      <div class="post-tags">
        <span class="post-badge ${TIPO_CLASS[p.tipo]}">${TIPO_LABEL[p.tipo]}</span>
        ${tags}
      </div>
      <h2 class="post-title"><a href="post.html?id=${p.id}">${p.titulo}</a></h2>
      <p class="post-excerpt">${p.descripcion}</p>
      ${files ? `<div class="post-tags">${files}</div>` : ''}
      <div class="post-actions">
        <a href="post.html?id=${p.id}" class="post-action-btn">
          <svg width="14" height="14" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 10h.01M12 10h.01M16 10h.01M9 16H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-5l-5 5v-5z"/></svg>
          <span>${p.comentarios} comentarios</span>
        </a>
        <button class="post-action-btn save-btn ${savedClass}" data-id="${p.id}" aria-label="Guardar">
          <svg width="14" height="14" fill="${p.guardado ? 'currentColor' : 'none'}" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z"/></svg>
          <span>${p.guardado ? 'Guardado' : 'Guardar'}</span>
        </button>
        <button class="post-action-btn" onclick="navigator.clipboard.writeText(window.location.origin+'/post.html?id=${p.id}')" aria-label="Copiar enlace">
          <svg width="14" height="14" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.368 2.684 3 3 0 00-5.368-2.684z"/></svg>
          <span>Compartir</span>
        </button>
      </div>
    </div>
  </article>`;
}

/* ── State ── */
let filteredPosts = [...NEXO.posts];
let activeTab = 'popular';
let searchQuery = '';

function sortPosts(arr) {
  if (activeTab === 'popular')  return [...arr].sort((a,b) => b.votos - a.votos);
  if (activeTab === 'reciente') return [...arr].sort((a,b) => b.id - a.id);
  if (activeTab === 'top')      return [...arr].filter(p => p.tipo === 'apunte').sort((a,b) => b.votos - a.votos);
  return arr;
}

function applyFilters() {
  const sede    = document.getElementById('filterSede')?.value;
  const carrera = document.getElementById('filterCarrera')?.value;
  filteredPosts = NEXO.posts.filter(p => {
    const matchSede    = !sede    || p.sede === NEXO.sedes.find(s => s.id == sede)?.nombre;
    const matchCarrera = !carrera || true; // enlazaría con comunidad en backend
    const matchSearch  = !searchQuery || p.titulo.toLowerCase().includes(searchQuery) || p.descripcion.toLowerCase().includes(searchQuery);
    return matchSede && matchCarrera && matchSearch;
  });
  renderFeed();
}

function renderFeed() {
  const container = document.getElementById('postsContainer');
  if (!container) return;
  const sorted = sortPosts(filteredPosts);
  if (sorted.length === 0) {
    container.innerHTML = `<div class="empty-state"><div class="empty-icon">📭</div><div class="empty-title">Sin resultados</div><div class="empty-desc">No hay publicaciones que coincidan con tu búsqueda o filtros.</div></div>`;
    return;
  }
  container.innerHTML = sorted.map(renderPost).join('');
}

/* ── Tabs ── */
document.querySelectorAll('.tab-btn').forEach((btn, i) => {
  const tabs = ['popular','reciente','top'];
  btn.addEventListener('click', () => {
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    activeTab = tabs[i];
    renderFeed();
  });
});

/* ── Search ── */
const searchInput = document.getElementById('globalSearchInput');
if (searchInput) {
  let timer;
  searchInput.addEventListener('input', e => {
    clearTimeout(timer);
    timer = setTimeout(() => {
      searchQuery = e.target.value.toLowerCase().trim();
      applyFilters();
    }, 280);
  });
}

/* ── Filter selects ── */
document.getElementById('filterSede')?.addEventListener('change', applyFilters);
document.getElementById('filterCarrera')?.addEventListener('change', applyFilters);

/* ── Votes ── */
document.addEventListener('click', e => {
  const voteBtn = e.target.closest('.vote-btn');
  if (voteBtn) {
    const id = Number(voteBtn.dataset.id);
    const dir = Number(voteBtn.dataset.dir);
    const post = NEXO.posts.find(p => p.id === id);
    if (!post) return;
    if (post.miVoto === dir) {
      post.votos -= dir; post.miVoto = 0;
    } else {
      post.votos += dir - post.miVoto; post.miVoto = dir;
    }
    applyFilters();
  }

  const saveBtn = e.target.closest('.save-btn');
  if (saveBtn) {
    const id = Number(saveBtn.dataset.id);
    const post = NEXO.posts.find(p => p.id === id);
    if (post) { post.guardado = !post.guardado; applyFilters(); }
  }
});

/* ── Create Post Modal ── */
const modal = document.getElementById('createPostModal');
const openBtn = document.getElementById('openCreatePostBtn');
const triggerInput = document.getElementById('triggerCreatePost');

function openModal() { modal?.classList.add('open'); }
function closeModal() { modal?.classList.remove('open'); }

openBtn?.addEventListener('click', openModal);
triggerInput?.addEventListener('click', openModal);
document.querySelectorAll('.close-modal-btn').forEach(b => b.addEventListener('click', closeModal));
modal?.addEventListener('click', e => { if (e.target === modal) closeModal(); });

document.getElementById('createPostForm')?.addEventListener('submit', e => {
  e.preventDefault();
  const titulo = document.getElementById('postTitleInput').value.trim();
  const tipo   = document.getElementById('postTagSelect').value;
  const desc   = document.getElementById('postContentInput').value.trim();
  if (!titulo || !desc) return;
  const newPost = {
    id: Date.now(), tipo, titulo, descripcion: desc,
    autor: NEXO.currentUser.alias, autor_inicial: NEXO.currentUser.inicial,
    comunidad:'Sistemas UTN-BA', comunidad_slug:'sistemas-utn-ba',
    materia:null, sede:'UTN-BA', votos:1, comentarios:0,
    tags:[], archivos:[], hace:'justo ahora', miVoto:1, guardado:false,
  };
  NEXO.posts.unshift(newPost);
  closeModal();
  e.target.reset();
  activeTab = 'reciente';
  document.querySelectorAll('.tab-btn').forEach((b,i) => b.classList.toggle('active', i===1));
  applyFilters();
});

/* ── ESC closes modal ── */
document.addEventListener('keydown', e => { if (e.key === 'Escape') closeModal(); });

/* ── Init ── */
renderFeed();

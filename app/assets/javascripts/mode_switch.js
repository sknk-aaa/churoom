document.addEventListener("turbo:load", () => {
  // ────────────────
  //① 既存のモード切替（時間／教室フォーム）
  // ────────────────
  const timeForm = document.getElementById("mode-time-form");
  const roomForm = document.getElementById("mode-room-form");
  const radios   = document.querySelectorAll('input[name="mode-select"]');

  function updateFormDisplay() {
    const sel = document.querySelector('input[name="mode-select"]:checked');
    if (!sel) return;
    sessionStorage.setItem("mode-select", sel.id);

    if (sel.value === "mode-time") {
      timeForm.style.display = "block";
      roomForm.style.display = "none";
    } else {
      timeForm.style.display = "none";
      roomForm.style.display = "block";
    }
  }

  if (timeForm && roomForm && radios.length) {
    // ページ読み込み時の復元
    const saved = sessionStorage.getItem("mode-select");
    if (saved) {
      const tgt = document.getElementById(saved);
      if (tgt) tgt.checked = true;
    }
    updateFormDisplay();
    radios.forEach(r => r.addEventListener("change", updateFormDisplay));
  }

  // ────────────────
  //② 新しく追加するモード切替（検索／使い方）
  // ────────────────
  const headerRadios   = document.querySelectorAll('input[name="mode-select-header"]');
  const searchSection  = document.getElementById("search-section");
  const aboutSection   = document.getElementById("about-section");

  function updateHeaderDisplay() {
    const sel = document.querySelector('input[name="mode-select-header"]:checked');
    if (!sel) return;
    // もし状態を残したいならこちらも sessionStorage に保存可能
    // sessionStorage.setItem("mode-select-header", sel.id);

    if (sel.value === "mode-search") {
      searchSection.style.display = "block";
      aboutSection.style.display  = "none";
    } else { // mode-about
      searchSection.style.display = "none";
      aboutSection.style.display  = "block";
    }
  }

  if (headerRadios.length && searchSection && aboutSection) {
    // 初期表示用（必要なら sessionStorage から復元）
    updateHeaderDisplay();
    headerRadios.forEach(r => r.addEventListener("change", updateHeaderDisplay));
  }
});

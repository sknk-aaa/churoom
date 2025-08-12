document.addEventListener("turbo:load", () => {
  // ハンバーガーメニューのトグル
  const btn = document.getElementById("hamburger-btn");
  const nav = document.getElementById("mobile-nav");
  if (!btn || !nav) return;

  btn.addEventListener("click", () => {
    const expanded = btn.getAttribute("aria-expanded") === "true";
    btn.setAttribute("aria-expanded", String(!expanded));
    btn.classList.toggle("is-active");
    nav.classList.toggle("is-open");
  });
  nav.addEventListener("click", () => {
    nav.classList.remove("is-open");
    btn.classList.remove("is-active"); 
    btn.setAttribute("aria-expanded", "false");
  });

  // モード切り替えの表示更新
  // ラジオボタンの切り替えでフォームの表示を更新
  const timeForm = document.getElementById("mode-time-form");
  const roomForm = document.getElementById("mode-room-form");
  const radios   = document.querySelectorAll('input[name="mode-select"]');

  if (!timeForm || !roomForm || radios.length === 0) return;

  function updateDisplay() {
    const selected = document.querySelector('input[name="mode-select"]:checked');
    if (!selected) return;

    if (selected.value === "mode-time") {
      timeForm.style.display = "block";
      roomForm.style.display = "none";
    } else { // mode-room
      timeForm.style.display = "none";
      roomForm.style.display = "block";
    }
  }

  // 初期表示
  updateDisplay();

  // ラジオボタンを切り替えたら表示を更新
  radios.forEach(radio => radio.addEventListener("change", updateDisplay));
});

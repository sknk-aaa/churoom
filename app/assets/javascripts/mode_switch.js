document.addEventListener("turbo:load", () => {
  const timeForm = document.getElementById("mode-time-form");
  const roomForm = document.getElementById("mode-room-form");
  const radios   = document.querySelectorAll('input[name="mode-select"]');

  if (!timeForm || !roomForm || radios.length === 0) return;

  // ページ読み込み時に sessionStorage から復元
  const saved = sessionStorage.getItem("mode-select");
  if (saved) {
    // id 属性と value が同じならこう、value なら value で検索
    const target = document.getElementById(saved);
    if (target) target.checked = true;
  }

  function updateDisplay() {
    const selected = document.querySelector('input[name="mode-select"]:checked');
    if (!selected) return;

    // 選択状態を sessionStorage に保存
    sessionStorage.setItem("mode-select", selected.id);

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

  // ラジオボタンを切り替えたら updateDisplay を呼ぶ
  radios.forEach(radio => radio.addEventListener("change", updateDisplay));
});

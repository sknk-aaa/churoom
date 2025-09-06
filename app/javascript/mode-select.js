document.addEventListener("DOMContentLoaded", () => {
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
    } else {
      timeForm.style.display = "none";
      roomForm.style.display = "block";
    }
  }

  updateDisplay();
  radios.forEach(radio => radio.addEventListener("change", updateDisplay));
});
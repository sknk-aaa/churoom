function onReady(fn){
  if (document.readyState !== "loading") fn();
  document.addEventListener("DOMContentLoaded", fn);
  document.addEventListener("turbo:load", fn);
}

onReady(() => {
  const btn = document.getElementById("hamburger-btn");
  const nav = document.getElementById("header__nav");
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
});
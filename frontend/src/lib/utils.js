import { monthNames } from '@constants';

export const bubblingEventBinder = bindTarget => (eventType, selector, callback) => {
  bindTarget.addEventListener(eventType, e => {
    const closestEl = e.target.closest(selector);
    if (!closestEl) {
      return;
    }
    if (!bindTarget.contains(closestEl)) {
      return;
    }
    callback(e);
  });
};

export const qs = (selector, base = document) => base.querySelector(selector);

export const qsa = (selector, base = document) => base.querySelectorAll(selector);

export const getFormattedDueDate = date =>
  `Due by ${monthNames[date.getMonth()]} ${date.getDate()}, ${date.getFullYear()}`;

export const getPercentage = (total, closed) =>
  total === 0 ? 0 : Math.floor((closed / total) * 100);

export const debounce = callback => setTimeout(callback, 1200);

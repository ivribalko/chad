import 'dart:html';

void watch(instance) {
  window.addEventListener('focus', instance.onFocus);
  window.addEventListener('blur', instance.onBlur);
}

void unwatch(instance) {
  window.removeEventListener('focus', instance.onFocus);
  window.removeEventListener('blur', instance.onBlur);
}

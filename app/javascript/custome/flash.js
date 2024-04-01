document.addEventListener("DOMContentLoaded", function () {
  // Находим кнопки delete
  const deleteNoticeButton = document.getElementById("delete-notice");
  const deleteAlertButton = document.getElementById("delete-alert");

  // Добавляем обработчик события на клик по кнопке delete
  if (deleteNoticeButton) {
    deleteNoticeButton.addEventListener("click", function () {
      // Удаляем уведомление
      const notification = this.parentElement;
      notification.remove();
    });
  }

  if (deleteAlertButton) {
    deleteAlertButton.addEventListener("click", function () {
      // Удаляем уведомление
      const notification = this.parentElement;
      notification.remove();
    });
  }
});

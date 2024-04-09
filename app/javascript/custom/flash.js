import $ from "jquery";

/* JS скрипты для уведомлений на проекте */

$(document).on("turbo:load", function () {
  // console.log("loaded Flash.js");
  const $deleteNoticeButton = $("#delete-notice");
  const $deleteAlertButton = $("#delete-alert");

  // Добавляем обработчик события на клик по кнопке delete
  $deleteNoticeButton.on("click", function () {
    // Удаляем уведомление
    $(this).parent().remove();
  });

  $deleteAlertButton.on("click", function () {
    // Удаляем уведомление
    $(this).parent().remove();
  });
});

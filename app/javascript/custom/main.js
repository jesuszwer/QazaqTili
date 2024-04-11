import $ from "jquery";

import "./answers"
import "./flash";

$(document).on("turbo:load", function () {
  if (window.location.pathname.match(/^\/questions\/\d+$/)) {
    // Ваш код здесь
    console.log(testData);
  }
});

// скрип для всплывающего окна

$(document).on("turbo:load", function () {
  $("#showOverlay").on("click", function () {
    $("#overlay").css("display", "flex");
  });

  $("#closeOverlay").on("click", function () {
    $("#overlay").css("display", "none");
  });
});

// скрип для кнопки назад

$(document).on("turbo:load", function () {
  // Проверяем, есть ли предыдущая страница при загрузке страницы
  if (document.referrer !== "") {
    $("#backButton").show(); // Если есть, показываем кнопку
  }

  // Обработчик события клика на кнопке
  $("#backButton").on("click", function () {
    window.history.back(); // Переход на предыдущую страницу
  });
});

import $ from "jquery";
//TODO в будущем раскидать все по файлам, если это будет более выгодно

// Скрип для завершения теста

$(document).on("turbo:load", function () {
  // console.log("loaded PostAnswerFunction.js");

  // Получить кнопку завершения теста
  const finishTestButton = document.querySelector("#finish-test-button");

  // Проверка наличия кнопки
  if (!finishTestButton) {
    return; // Выйти из функции, если кнопка не найдена
  }

  // Обработчик события клика по кнопке завершения теста
  finishTestButton.addEventListener("click", function () {
    // Получить все элементы с классом "box"
    const questions = document.querySelectorAll(".box");

    // Получить ID теста из URL
    const testId = window.location.pathname.split("/").pop();

    // Создать массив для хранения данных ответов
    const jsonData = [];

    // Перебор вопросов
    questions.forEach(function (question) {
      // Получить ID вопроса из имени элемента radio
      const questionId = question
        .querySelector("input[type='radio']:checked")
        .getAttribute("name");

      // Получить текст вопроса
      const questionContent = question.querySelector("h2").textContent;

      // Получить выбранный вариант ответа
      const selectedOption = question.querySelector(
        "input[type='radio']:checked"
      );

      // Проверка наличия выбранного варианта
      if (selectedOption) {
        // Получить текст выбранного варианта
        const answerContent = selectedOption.parentElement.textContent.trim();

        // Добавить данные ответа в массив
        jsonData.push({
          question_id: questionId,
          content: questionContent,
          question_answer: answerContent,
        });
      }
    });

    console.log(jsonData); // Вывод массива данных ответов в консоль

    // Отправка JSON на сервер
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    fetch("/answers", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
        "X-Test-ID": testId,
      },
      body: JSON.stringify(jsonData),
    })
      .then((response) => {
        if (response.status === 201) {
          // Обработка ответа сервера
          //TODO потом нужно будет подумать над перенаправлением пользователя
          window.location.href = "/answers";
        } else {
          response.json().then((errorData) => {
            // Отображение ошибок на странице
            console.error("Ошибки:", errorData.errors);
          });
        }
      })
      // .then((data) => console.log(data)) // Вывод ответа сервера в консоль
      //TODO нужно подумать над добавлением нормального логера
      .catch((error) => console.error("Ошибка:", error));
  });
});

// таймер обновления страницы

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

// скрип для выбора изображения

// $(document).on("turbo:load", function () {
//   $('input[type="file"]').on("change", function () {
//     // Получаем имя выбранного файла
//     var fileName = $(this)[0].files[0].name;
//     // Обновляем текстовое содержимое элемента с id="file-name"
//     $("#file-name").text(fileName);
//   });
// });

// $(document).on("turbo:load", function() {
//   $('#user_avatar').on('change', function(event) {
//       var input = event.target;
//       var reader = new FileReader();
//       var text = $('#avatar-preview-text')
//       reader.onload = function() {
//           var img = $('#avatar-preview');
//           img.attr('src', reader.result);
//           img.css('display', 'block'); // Показываем изображение после загрузки
//           text.css('display', 'none');
//       }
//       reader.readAsDataURL(input.files[0]); // Читаем файл как Data URL
//   });
// });

import $ from "jquery";

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
          window.location.href = '/';
        } else {
          response.json().then((errorData) => {
            // Отображение ошибок на странице
            console.error("Ошибки:", errorData.errors);
          });
        }
      })
      .then((data) => console.log(data)) // Вывод ответа сервера в консоль
      .catch((error) => console.error("Ошибка:", error));
  });
});

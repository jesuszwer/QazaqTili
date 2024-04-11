// Скрип для завершения теста
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
          console.log("Ответы успешно сохранены");

          // testData это массив с данными вопросов и ответов
          // jsonData это массив с данными ответов от пользователя

          let request_data = []; // Объявляем переменную request_data до ее использования
          let all_balls = 0; // Объявляем переменную all_balls, если она используется

          testData.questions.forEach(function (question, index) {
            let question_data = {}; // Создаем объект для данных текущего вопроса
            jsonData.forEach(function (answer) {
              if (question.question_content === answer.content) {
                // Сравниваем текст вопроса с текстом ответа
                let userAnswer = answer.question_answer;
                let correctAnswer = question.options.find(
                  (option) => option.is_correct
                ).option_content;
                let ball = userAnswer === correctAnswer ? 1 : 0;
                question_data = { userAnswer, correctAnswer, ball }; // Записываем данные ответа в объект question_data
                all_balls += ball; // Увеличиваем общее количество баллов
              }
            });
            request_data.push(question_data); // Добавляем объект question_data в массив request_data
          });

          request_data.push({ all_balls }); // Добавляем общее количество баллов в массив request_data

          fetch("/results", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "X-CSRF-Token": csrfToken,
              "X-Test-ID": testId,
            },
            body: JSON.stringify(request_data),
          }).then((response) => {
            if (response.status === 201) {
              console.log("Результаты успешно сохранены");
            } else {
              response.json().then((errorData) => {
                console.error("Ошибки:", errorData.errors);
                alert("Произошла ошибка при сохранении результатов");
                return
              });
            }
          });

          window.location.href = "/answers";
        } else {
          response.json().then((errorData) => {
            console.error("Ошибки:", errorData.errors);
          });
        }
      })
      // .then((data) => console.log(data)) // Вывод ответа сервера в консоль
      //TODO нужно подумать над добавлением нормального логера
      .catch((error) => console.error("Ошибка:", error));
  });
});

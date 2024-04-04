// document.addEventListener("DOMContentLoaded", function () {
//   function testingAnswer() {
//     const questions = document.querySelectorAll(".box");

//     const jsonData = [];

//     questions.forEach(function (question) {
//       const id = question.dataset.questionId;
//       const content = question.querySelector("h2").textContent;
//       const selectedOption = question.querySelector(
//         "input[type='radio']:checked"
//       );

//       if (selectedOption) {
//         const answerContent = selectedOption.parentElement.textContent.trim();
//         jsonData.push({
//           id: id,
//           content: content,
//           question_answer: answerContent,
//         });
//       }
//     });

//     // Отправляем JSON на сервер
//     fetch("/your_controller/action", {
//       method: "POST",
//       headers: {
//         "Content-Type": "application/json",
//       },
//       body: JSON.stringify(jsonData),
//     })
//       .then((response) => response.json())
//       .then((data) => console.log(data))
//       .catch((error) => console.error("Ошибка:", error));
//   }
// });

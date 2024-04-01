# Создаем вопросы
questions = [
  { content: 'Как называется столица Франции?' },
  { content: 'Сколько планет в Солнечной системе?' },
  { content: 'Кто написал произведение "Война и мир"?' }
]

# Заполняем вопросы в базе данных
questions.each do |question_params|
  question = Question.create!(question_params)

  # Создаем ответы для каждого вопроса
  case question.content
  when 'Как называется столица Франции?'
    options = [
      { content: 'Лондон' },
      { content: 'Рим' },
      { content: 'Париж', correct: true },
      { content: 'Мадрид' }
    ]
  when 'Сколько планет в Солнечной системе?'
    options = [
      { content: '6' },
      { content: '8', correct: true },
      { content: '10' },
      { content: '12' }
    ]
  when 'Кто написал произведение "Война и мир"?'
    options = [
      { content: 'Лев Толстой', correct: true },
      { content: 'Федор Достоевский' },
      { content: 'Александр Пушкин' },
      { content: 'Иван Тургенев' }
    ]
  end

  # Заполняем ответы в базе данных
  options.each do |option_params|
    question.options.create!(option_params)
  end
end

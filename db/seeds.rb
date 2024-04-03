# # Создаем тесты
# tests = [
#   { name: "Тест по математике",
#     description: "Тест по математике",
#     category: "math"}
# ]

# questions_data = [
#   { content: "Сколько будет 2+2?",
#     question_type: "math",
#     test_id: 2}
# ]

# tests.each do |test_attrs|
#   Test.create!(test_attrs)
# end
# puts "Тесты успешно созданы"


# questions_data.each do |question_attrs|
#   Question.create!(question_attrs)
# end
# puts "Вопросы успешно созданы"


option_data = [
  { content: "2",
    question_id: 7,
    correct: true},
  { content: "3",
    question_id: 7,
    correct: false},
  { content: "4",
    question_id: 7,
    correct: false},
  { content: "5",
    question_id: 7,
    correct: false}
]

option_data.each do |option_attrs|
  Option.create!(option_attrs)
end

puts "Варианты ответов успешно созданы"

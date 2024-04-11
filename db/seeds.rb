tests_data = [
  {
    name: "Тест по казахскому языку",
    description: "Тест по казахскому языку",
    created_at: DateTime.now,
    updated_at: DateTime.now,

    json_contents: {
      "type": "общее",
      "test_name": "Тест по казахскому языку",
      "questions": [
        {
          "question_content": "Как переводится на казахский язык фраза 'Привет, как дела'?",
          "options": [
            {
              "option_content": "Сәлем, несiздердiң дурстықтары жақсы ма?",
              "is_correct": true
            },
            {
              "option_content": "Салем, несiздiң жақсы ма?",
              "is_correct": false
            },
            {
              "option_content": "Сәлем, несiздердiң күндерi жақсы ма?",
              "is_correct": false
            },
            {
              "option_content": "Сәлем, несiздiң кессе жақсы ма?",
              "is_correct": false
            }
          ]
        },
        {
          "question_content": "Как переводится слово 'книга' на казахский язык?",
          "options": [
            {
              "option_content": "Кітап",
              "is_correct": true
            },
            {
              "option_content": "ТақтаЖ",
              "is_correct": false
            },
            {
              "option_content": "ПераЖ",
              "is_correct": false
            },
            {
              "option_content": "КешеЖ",
              "is_correct": false
            }
          ]
        },
        {
          "question_content": "Выберите правильный вариант написания слова 'школа' на казахском языке:",
          "options": [
            {
              "option_content": "Мектеп",
              "is_correct": true
            },
            {
              "option_content": "Билім",
              "is_correct": false
            },
            {
              "option_content": "Кітап",
              "is_correct": false
            },
            {
              "option_content": "Қалай?",
              "is_correct": false
            }
          ]
        },
        {
          "question_content": "Как переводится на казахский язык фраза 'Я люблю казахскую кухню'?",
          "options": [
            {
              "option_content": "Мен қазақ ас артуым",
              "is_correct": true
            },
            {
              "option_content": "Мен көк артуым",
              "is_correct": false
            },
            {
              "option_content": "Сіз келе жатырсыз ба?",
              "is_correct": false
            },
            {
              "option_content": "Таққа емсік береміз ба?",
              "is_correct": false
            }
          ]
        },
        {
          "question_content": "Как переводится слово 'дом' на казахском языке?",
          "options": [
            {
              "option_content": "Үй",
              "is_correct": true
            },
            {
              "option_content": "Мектеп",
              "is_correct": false
            },
            {
              "option_content": "Кітап",
              "is_correct": false
            },
            {
              "option_content": "Деректі",
              "is_correct": false
            }
          ]
        },
        {
          "question_content": "Выберите правильный вариант для слова 'мама' на казахском языке:",
          "options": [
            {
              "option_content": "Ана",
              "is_correct": true
            },
            {
              "option_content": "Абай",
              "is_correct": false
            },
            {
              "option_content": "Адам",
              "is_correct": false
            },
            {
              "option_content": "Алатыр",
              "is_correct": false
            }
          ]
        },
        {
          "question_content": "Как переводится на казахский язык фраза 'Спасибо за помощь'?",
          "options": [
            {
              "option_content": "Көмек үшін рақмет",
              "is_correct": true
            },
            {
              "option_content": "Бізге көмек қылыңыз",
              "is_correct": false
            },
            {
              "option_content": "Рахмет, осы жерде",
              "is_correct": false
            },
            {
              "option_content": "Үкіметке рахмет",
              "is_correct": false
            }
          ]
        },
        {
          "question_content": "Как переводится слово 'солнце' на казахском языке?",
          "options": [
            {
              "option_content": "Күн",
              "is_correct": true
            },
            {
              "option_content": "Ауа",
              "is_correct": false
            },
            {
              "option_content": "Аспан",
              "is_correct": false
            },
            {
              "option_content": "Тау",
              "is_correct": false
            }
          ]
        },
        {
          "question_content": "Выберите правильный вариант для слова 'вода' на казахском языке:",
          "options": [
            {
              "option_content": "Су",
              "is_correct": true
            },
            {
              "option_content": "Абай",
              "is_correct": false
            },
            {
              "option_content": "Таң",
              "is_correct": false
            },
            {
              "option_content": "Ай",
              "is_correct": false
            }
          ]
        },
        {
          "question_content": "Как переводится на казахский язык фраза 'Как тебя зовут'?",
          "options": [
            {
              "option_content": "Сенің атың не?",
              "is_correct": true
            },
            {
              "option_content": "Сенің ағашың күйде қарай аласыз ба?",
              "is_correct": false
            },
            {
              "option_content": "Сенің көңіліңде не бар?",
              "is_correct": false
            },
            {
              "option_content": "Сен ол жерде баста берейін бе?",
              "is_correct": false
            }
          ]
        }
      ]
    },
    types: "base"
  }
]

tests_data.each do |test|
  Test.find_or_create_by(test)
end

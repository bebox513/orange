5.times do |n|
  name = Faker::Name.name
  User.create!(
    email: "test#{n + 1}@test.com",
    name: name,
    password: "password",
    password_confirmation: "password",
    role: 1
  )
end

User.where(role: 1).each do |user| #役職１ユーザーを全て取得して全ユーザーに対して同じ処理をする。
  100.times do |n| #１００回同じ処理をする。
    temperature = [36.3, 36.4, 36.5, 36.6, 36.7, 36.8]
    date = Date.today - n
    meal_intake = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    name = user.name
    notes1 = ["体調の変化はなく、",
      "普段の様子と変わらず、",
      "体調の変わりなく",
      "特におかしなところなく、",
      "いつもと変わらない様子で、"
    ]
    notes2 = ["自分のペースで過ごしていた。",
      "マイペースに過ごしていた。",
      "昼寝をしたりして過ごしていた",
      "テレビを見て過ごしていた。",
      "将棋を指したりして過ごしていた。"
    ]
    notes3 = ["お風呂にもゆっくりと浸かっており、",
      "昔の話を聞かせてくれたり、"
    ]
    notes4 = "落ち着いていた。"
    notes5 = ["",
      "一度自分で用を足したときに失敗してズボンを汚してしまったが、介助して問題なく終えた。",
      "食事中に激しく咳き込むことがあったが、食事を５分程休憩すると改善した様子だった。",
      "昨晩あまり寝付けなかったと言っていた。最近寝付きが悪いようだ。",
      "机を拭いてくれたり、掃き掃除を手伝ってくれた。お礼を言うと少し照れているようだった。"
    ]
    notes = notes1.sample + notes2.sample + notes3.sample + notes4 + notes5.sample
    user_id = user.id
    CareDiary.create!(
      notes: notes,
      temperature: temperature.sample,
      date: date,
      breakfast_meal_intake: meal_intake.sample,
      lunch_meal_intake: meal_intake.sample,
      dinner_meal_intake: meal_intake.sample,
      name: name,
      user_id: user_id
    )
  end
end

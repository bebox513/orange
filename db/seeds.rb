6.times do |n|
  name = Faker::Name.name
  User.create!(
    email: "1test#{n + 1}@test.com",
    name: name,
    password: "password",
    password_confirmation: "password",
    role: 1,
  )
end

2.times do |i|
  6.times do |n|
    company = ["武豊福寿園", "くすのきの里", "医療法人かくわ会", "瑞光の里", "むらさき野苑" ]
    name = Faker::Name.name
    User.create!(
      email: "#{i + 2}test#{n + 1}@test.com",
      name: name,
      password: "password",
      password_confirmation: "password",
      role: i + 2,
      company: company.sample
    )
  end
end

User.where(role: 1).each do |user|
  100.times do |n|
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

User.where(role: 2).each do |user|
  100.times do |n|
    name = Faker::Name.name
    sex = [1, 2]
    birthday = Faker::Date.between(from: '1921-01-01', to: '1941-01-01')
    age = (Date.today.strftime('%Y%m%d').to_i - birthday.strftime('%Y%m%d').to_i) / 10000
    facility_in_charge = ["ゆとり", "武豊福寿園", "ケアプラン老健", "ケアシス", "ゆめじろう", "ケアプラン榊原", "かくわ", "渡邉"]
    manager_in_charge = Faker::Name.name
    degree_care_required = [1, 2, 3, 4, 5]
    dementia = [1, 2]
    notes = ["日常動作は基本的に自立にて行われる、昔は料理が好きでよく作っていた。
             家事の手伝いは好きなので、机拭き、食器の片付け、掃除等、できる範囲で役割を与えて欲しい。
             他者と関わるのも好きで、社交的なので会話が弾むよう配慮して欲しい。"
    ]
    user_id = user.id
    CareRecipient.create!(
      name: name,
      sex: sex.sample,
      birthday: birthday,
      age: age,
      facility_in_charge: facility_in_charge.sample,
      manager_in_charge: manager_in_charge,
      degree_care_required: degree_care_required.sample,
      dementia: dementia.sample,
      notes: notes.sample,
      user_id: user_id
    )
  end
end

User.ids.each do |follower_user_id|
  User.ids.shuffle.each do |following_user_id|
    if follower_user_id != following_user_id && rand(4) == 0
      Relationship.create!(
        follower_id: follower_user_id,
        following_id: following_user_id
      )
    end
  end
end

20.times do |n|
  User.all.shuffle.each do |user|
    if rand(2) + 1 == 1
      content1 = [
        "今日も介護疲れたけどよく頑張った！！ご褒美にケーキ買おう♪",
        "うどん久しぶりに食べたけどすっごい美味しかった！！",
        "最近息子が介護を手伝ってくれることが増えてとても助かる！！
        お父さんが強く言ってくれたからだね！",
        "スーパーで最近売り始めた卵がすごい安い！！",
        "今日とっても寒くて驚いちゃった、、、
        毛布を増やそう！！",
      ]
      content2 = [
        "かるた大会を施設で行いました。とても盛り上がり、
        勝負も白熱しました！！優勝者には施設長から賞状が贈られております。
        毎月行っておりますので、次回の参加希望もお待ちしております！！",
        "いつも掃除を手伝ってくださる方に、施設からお礼のプレゼントをさせていただきました。
        とても喜んでくださり、「また頑張るね」とおっしゃってくださりました。",
        "おやつの時間に皆さんで手作りホットケーキを食べました！！
        抹茶味、チョコレート味と、沢山のホットケーキを作り、美味しくいただきました。
        少し焦がしてしまうこともありましたが、皆さん楽しそうに過ごされています。"
      ]
      if user.role == 1
        content = content1
      else
        content = content2
      end
      Post.create!(
        user_id: user.id,
        content: content.sample
      )
    end
  end
end

Post.all.each do |post|
  User.ids.shuffle.each do |user_id|
    if post.user_id != user_id && rand(4) == 0
      Like.create!(
        user_id: user_id,
        post_id: post.id
      )
    end
  end
end

Post.all.each do |post|
  User.ids.each do |user_id|
    content1 = ["とっても素敵ですね！",
                "それはいいと思います。",
                "素晴らしい！！"
    ]
    content2 = ["いつもいつもありがとうございます",
                "とっっても素敵ですね",
                "行事楽しそうでなによりです！",
                "楽しそう！",
                "またよろしくおねがいします！"
    ]
    if post.user_id != user_id && rand(4) == 0
      if post.user.role == 1
        content = content1
      else
        content = content2
      end
      Comment.create!(
        post_id: post.id,
        user_id: user_id,
        content: content.sample
      )
    end
  end
end

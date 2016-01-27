namespace :data do
  desc 'Cleanup all data.'
  task reset: :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end

  desc 'Fill database with fake data'
  task populate: :environment do |t, args|
    bench = Benchmark.measure do
      traveller = User.create_faker(with_portrait: true)
      traveller.active!
      3.upto(5).each do |month|
        traveller.travels.create!(departure_at: Time.local(2016, month, rand(1..10)), return_at: Time.local(2016, month, rand(20..27))).tap do |travel|
          travel.set_destinations!(Country.all.sample(rand(1..3)))
          3.times do
            User.create_faker(with_portrait: true).tap do |user|
              user.active!
              3.times do
                deal = user.deals.create!({ travel: travel, content: "#{brands.sample} #{colors.sample} 货号#{Faker::Company.duns_number}", expected_quantity: rand(1..3) }.merge(
                  case rand(1..3)
                  when 1 then {}
                  when 2 then { acceptable_price_value: rand(100..500) * 10 }
                  when 3 then { acceptable_price_value: rand(100..500) * 5, acceptable_price_currency_id: Currency.circulation_in(travel.destinations).sample.id }
                  end
                ))
                rand(1..3).times {
                  deal.photographs.create!(type: :sample, file: fake_image_file)
                }
              end
            end
          end
        end
      end
    end
    p "finished in #{bench.real} second(s)"
  end

  def brands
    ['蔻驰（COACH）',
      '迈克.科尔斯（MICHAEL KORS）',
      '普拉达（PRADA）',
      '古驰（GUCCI）',
      '巴宝莉（BURBERRY）',
      '路易威登（LV）',
      '巴利（BALLY）',
      '菲拉格慕（Ferragamo）',
      '托里伯奇（Tory Burch）',
      '芬迪（FENDI）',
      '途明（TUMI）',
      '阿玛尼（ARMANI）',
      '凯特丝蓓（KATE SPADE）',
      '香奈儿（Chanel）',
      '克洛伊（CHLOE）',
      '宝缇嘉（BOTTEGA VENETA）',
      '日默瓦（RIMOWA）',
      '范思哲（VERSACE）',
      '姬龙雪（guy laroche）',
      '芙拉（FURLA）',
      '凯浦林（Kipling）',
      '缪缪（MiuMiu）',
      '珑骧（Longchamp）',
      '万宝龙（MONTBLANC）',
      '迪奥（Dior）',
      '纪梵希（Givenchy）']
  end

  def colors
    ['忍冬藤色',
      '水蓝色',
      '水晶色',
      '驼色',
      '绿松石蓝',
      '柔和蓝',
      '山茶色',
      '淡蓝色',
      '红褐色',
      '沙棕色(较暗)',
      '芥子色',
      '冬季树',
      '灰质偏紫',
      '秋菊色',
      '灰质偏黄',
      '冬季黄昏']
  end

  def fake_image_file
    abstract_image_filename = File.open(File.join(Rails.root, 'public', 'abstract_images', "#{rand(1..200).to_s.rjust(3, '0')}.jpg"))
  end
end
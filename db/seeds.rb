def flag_file code
  File.open(File.join(Rails.root, 'public', 'flags', "#{code}.png"))
end

Country.create!([
  { zh_name: '美国', en_name: 'United States', flag: flag_file('United-States'), featured: false },
  { zh_name: '英国', en_name: 'England', flag: flag_file('England'), featured: false },
  { zh_name: '日本', en_name: 'Japan', flag: flag_file('Japan'), featured: false },
  { zh_name: '韩国', en_name: 'South Korea', flag: flag_file('South-Korea'), featured: false },
  { zh_name: '泰国', en_name: 'Thailand', flag: flag_file('Thailand'), featured: false },
  { zh_name: '菲律宾', en_name: 'Philippines', flag: flag_file('Philippines'), featured: false },
  { zh_name: '中国香港', en_name: 'Hong Kong', flag: flag_file('China'), featured: false },
  { zh_name: '中国澳门', en_name: 'Macau', flag: flag_file('China'), featured: false },
  { zh_name: '中国台湾', en_name: 'Taiwan', flag: flag_file('China'), featured: false },
  { zh_name: '意大利', en_name: 'Italy', flag: flag_file('Italy'), featured: false },
  { zh_name: '德国', en_name: 'Germany', flag: flag_file('Germany'), featured: false },
  { zh_name: '法国', en_name: 'France', flag: flag_file('France'), featured: false },
  { zh_name: '澳大利亚', en_name: 'Australia', flag: flag_file('Australia'), featured: false },
  { zh_name: '新西兰', en_name: 'New Zealand', flag: flag_file('New-Zealand'), featured: false },
  { zh_name: '阿联酋', en_name: 'United Arab Emirates', flag: flag_file('United-Arab-Emirates'), featured: false },
  { zh_name: '西班牙', en_name: 'Spain', flag: flag_file('Spain'), featured: false },
  { zh_name: '荷兰', en_name: 'Netherlands', flag: flag_file('Netherlands'), featured: false },
  { zh_name: '俄罗斯', en_name: 'Russia', flag: flag_file('Russia'), featured: false }
])

Currency.create!([
  { name: '美元', iso_code: 'USD', rate_of_exchange: 0.1521 },
  { name: '英镑', iso_code: 'GBP', rate_of_exchange: 0.1072 },
  { name: '日元', iso_code: 'JPY', rate_of_exchange: 17.8366 },
  { name: '韩元', iso_code: 'KRW', rate_of_exchange: 183.9082 },
  { name: '泰铢', iso_code: 'THB', rate_of_exchange: 5.5118 },
  { name: '比索', iso_code: 'PHP', rate_of_exchange: 7.2787 },
  { name: '港元', iso_code: 'HKD', rate_of_exchange: 1.1874 },
  { name: '澳门元', iso_code: 'MOP', rate_of_exchange: 1.2232 },
  { name: '新台币', iso_code: 'TWD', rate_of_exchange: 5.1183 },
  { name: '欧元', iso_code: 'EUR', rate_of_exchange: 0.1398 },
  { name: '澳元', iso_code: 'AUD', rate_of_exchange: 0.2194 },
  { name: '新西兰元', iso_code: 'NZD', rate_of_exchange: 0.2353 },
  { name: '迪拉姆', iso_code: 'AED', rate_of_exchange: 0.5585 },
  { name: '卢布', iso_code: 'RUB', rate_of_exchange: 12.4493 }
])

Circulation.create!([
  { country: Country.where(zh_name: '美国').first, currency: Currency.where(name: '美元').first },
  { country: Country.where(zh_name: '英国').first, currency: Currency.where(name: '英镑').first },
  { country: Country.where(zh_name: '日本').first, currency: Currency.where(name: '日元').first },
  { country: Country.where(zh_name: '韩国').first, currency: Currency.where(name: '韩元').first },
  { country: Country.where(zh_name: '泰国').first, currency: Currency.where(name: '泰铢').first },
  { country: Country.where(zh_name: '菲律宾').first, currency: Currency.where(name: '比索').first },
  { country: Country.where(zh_name: '中国香港').first, currency: Currency.where(name: '港元').first },
  { country: Country.where(zh_name: '中国澳门').first, currency: Currency.where(name: '澳门元').first },
  { country: Country.where(zh_name: '中国台湾').first, currency: Currency.where(name: '新台币').first },
  { country: Country.where(zh_name: '意大利').first, currency: Currency.where(name: '欧元').first },
  { country: Country.where(zh_name: '德国').first, currency: Currency.where(name: '欧元').first },
  { country: Country.where(zh_name: '法国').first, currency: Currency.where(name: '欧元').first },
  { country: Country.where(zh_name: '澳大利亚').first, currency: Currency.where(name: '澳元').first },
  { country: Country.where(zh_name: '新西兰').first, currency: Currency.where(name: '新西兰元').first },
  { country: Country.where(zh_name: '阿联酋').first, currency: Currency.where(name: '迪拉姆').first },
  { country: Country.where(zh_name: '西班牙').first, currency: Currency.where(name: '欧元').first },
  { country: Country.where(zh_name: '荷兰').first, currency: Currency.where(name: '欧元').first },
  { country: Country.where(zh_name: '俄罗斯').first, currency: Currency.where(name: '卢布').first }
])
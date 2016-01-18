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
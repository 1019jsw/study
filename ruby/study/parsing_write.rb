require 'open-uri'
require 'nokogiri'

searchAPI = {
  :googleAPI => "https://www.google.co.kr/search?q=",
  :naverAPI => "http://search.naver.com/search.naver?query=",
  :daumAPI => "http://search.daum.net/search?q="
}

def parsingHtml(url)
  page = Nokogiri::HTML(open(url))
  parsingResult = page.search("body").inner_html
  return parsingResult
end

def writeFile(key, parsingResult)

  # file exist check
  if File.exist?(key.to_s + ".txt")
    file = File.open(key.to_s + ".txt", "a+")
  else
    file = File.open(key.to_s + ".txt", "w")
  end

  file.puts(Time.now.strftime("%Y년 %m월 %d일 %H시 %M분 %S초"))
  file.puts(parsingResult)
  file.close
end

while true
  print "검색 값을 입력하세요 <body>만 추출합니다: "
  inputSearchParam = gets.chomp
  searchAPI.each_key do|key|
    searchParam = searchAPI[key] + inputSearchParam
    parsingResult = parsingHtml(searchParam)
    writeFile(key, parsingResult)
  end
  puts "검색 결과가 저장되었습니다"
end
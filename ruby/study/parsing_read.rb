searchAPI = {
    :googleAPI => "googleAPI.txt",
    :naverAPI => "naverAPI.txt",
    :daumAPI => "daumAPI.txt"
}

searchAPI.each_key do|key|
  file = File.open(searchAPI[key],"r")
  puts "["+ key.to_s + "] 입니다"

  file.each do |line|
    puts line
  end

  file.close
  puts "===================================="
end
- irb : 명령행 히스토리를 완벽하게 지원하고, 줄편집, 작업 제어 등의 기능이 있는 루비 셸 프로그램이다.
- RDoc : 시스템을 사용해서 내부적으로 문서를 포함하고있다. HTML, ri형식으로 변환이 가능하다.
	- 참고 (http://www.ruby- doc.org)
- ri : 같은 문서를 로컬에서 볼 수 있는 명령행 뷰어 프로그램
	- ri ClassName으로 입력
	- 특정 메서드에 대한 정보를 얻고자 한다면, 메소드의 이름을 매개변수로 넘겨주면 된다
	- 일반적인 도움말 : ri --help

- 객체를 만들때 가장 일반적인 방법은 new 메서드를 호출하는 것이다
	- ex) song1 = Song.new("Ruby Tuesday")
- 객체를 만들 때 클래스에 생성자(constructor)를 호출한다
- 자바와 달리 루비는 숫자 객체가 절대값을 구하는 기능을 포함하고 있다
	- ex) number = Math.abs(number) //자바코드
	- number = number.abs
- 한 줄에 하나의 표현식만 쓴다면, 줄의 끝부분에 세미콜론을 꼬박꼬박 넣을 필요가 없다.
- 주석문은 #문자로 시작해서 그줄의 끝까지 적용된다.
- 메서드의 선언부와 내용 부분을 구분하기 위해서 중괄호({})를 사용하지 않는다.
	대신 메서드 끝부분에 키워드 end를 써준다.

- 문자열 리터럴의 차이
	- 작은따옴표(single-quoted)로 묶인경우 루비가 매우 사소한 작업만한다.
		- 문자열 리터럴에 입력한 값이 그대로 객체의 값이 된다.
    - 큰따옴표(double-quoted)를 사용하는 경우
    	1. 백슬래시(＼)로 시작하는 문자를 찾아서 이진값으로 바꾸는 작업을 한다
    		- 대표적인 것이 '＼n' 이다
		2. 표현식 삽입이다. 문자열 안에 #{expression}과 같은 형태가 있으면 이는 expression의 값으로 변환된다
			- ex) def say_goodnight(name)
			-  result = "Goodnight, #{name}"
			- 루비가 문자열 객체를 생성할 때, 변수 name의 현재 값을 찾아서 그 값을 문자열에 삽입해주는 것 이다. #{*}안에는 다소 복잡한 표현식을 써도 된다.
				- ex) "Goodnight, #{name.capitalize}" =>문자열의 capitalize 메서드 호출

- 변수와 클래스 이름
	- 상수, 클래스 이름 : 대문자로 시작
		- PI => 한 번 정의한 상수를 다시 정의할 수 없다
		- FeetperMile
		- String
		- MyClass
		- JassSong
	- 전역변수
		- $debug
		- $CUSTOMER
		- $_
		- $plan9
		- $Global
	- 인스턴스 변수
		- @name
		- @pont_1
		- @X
		- @_
		- @plan9
	- 클래스 변수
		- @@total
		- @@symtab
		- @@N
		- @@x_pos
		- @@SINGLE
    - 지역 변수
    	- name
    	- fish_and_chips
    	- x_axis
    	- thx1138
    	- _26

	-  $greeting = "Hello"
	    @name = "Prudence"
		puts "#@greeting, #@name"
		실행결과 : Hello, Prudence

    - *을 사용하면 문자열을 지정한 숫자만큼 연결할 수 있다

- 루비 메서드에서 반환하는 값은 마지막으로 실행된 표현식의 결과값이다
	- def say_goodnight(name)
		"Goodnignt, #{name}"
        end
        puts say_goodnight('Ma')
        실행결과 : Goodnight, Ma

- 배열과 해시
	- 새로운 요소를 담기위해서 공간이 더필요해지면 필요한 만큼 스스로 확장
	- 배열
		- 정수, 문자열, 실수를 모든 구성요소로 갖는 배열생성 가능
		- a = [1, '고양이', 3.14]
			a[0] -> 1
            a[2] = nil
            a -> [1, '고양이', nil]
		- 단축문법
			- a = ['개미', '벌', '고양이', '개', '엘크']
		    	a[0] -> "개미"
                a[3] -> "개"
         	   a = %w{개미 벌 고양이 개 엘크}
		 	    a[0] -> "개미"
                a[3] -> "개"

         -  a.clear 를 사용하여 배열을 비울수있다
         -  a = Array.new(숫자) 를 사용하여 배열 생성
         	a = Array.new 생성할 경우 빈 배열 생성
            a = Array.new(3, 1) =>3요소의 1개의 값들을 넣을수 있는 배열
         - 빈 요소를 참조하면 nil 반환
         - 다차원배열 형태 a = [ [1, 2, 3], [4, 5, 6] ]

	- 해시
		- 리터럴은 대괄호 대신 중괄호 {}를 사용
		- 두 개의 객체를 포함, 하나는 키, 하나는 값
		- 특정 해시 안에서 키는 유일한 값이어야 한다
		- 키와 값에는 어떠한 객체가 와도 상관없다(값이 배열이거나 키가 해시도 가능)
		- instSection = {
        	‘첼로‘ => ‘현악기‘,
            ‘클라리넷‘ => ‘관악기‘,
            ‘드럼‘  => ‘타악기‘,
            ‘오보에‘  => ‘관악기‘,
            ‘트럼펫‘  => ‘금관악기‘,
            ‘바이올린‘ => ‘현악기‘
            }
            instSection[‘오보에‘] → “관악기“
            instSection[‘첼로‘]  → “현악기“
            instSection[‘바순‘]  → nil
		- 값이 없을 경우 기본적으로 nil을 반환
		- 기본값을 변경도 가능하다
			ex) 각각의 키가 몇번 나타나는지 기록하는 해시를 만든다고 하면
            histogram = Hash.new(0)
            histogram['key1'] -> 0
            histogram['key1'] = histogram['key1'] + 1
            histogram['key1'] -> 1

        - 해쉬를 비우려면 a = {}
        - a = Hash.new
        - 빈 값엔 nil이 들어간다
        - 삭제 시 a.delete("key")

- 제어문
	- 제어문의 코드에 중괄호가 없다
	- 마지막을 나타내기 위해 end 키워드를 사용
		- if
			- if count < 10
				puts "Try again"
                elsif tries == 3
                puts "You lose"	
                else
                puts "Enter a number"
                end

		- while
			- while weight > 100 and num_Pallets >= 30
				pallet = next_Pallet() 
                weight += pallet.weight
                numPallets += 1
                end

            - nil 활용
            	gets메서드는 표준 스트림의 다음 줄을 반환한다. 파일의 끝에
                도달할 경우  특별히 nil을 반환
                조건문에서 nil을 거짓으로 간주

                while line = gets
                puts line.downcase
                end

                line변수에 다음줄의 텍스트나 nil을 넣는다. nil이 되면 루프를 끝냄

    - 구문 변경자(statement modifier)
    	- if radiation > 3000
            puts “위험합니다.“
            end

            =>
            puts “위험합니다“ if radiation > 3000

            square = 2
            while square < 1000
            square = square*square
            end

            =>
            square = 2
            square = square*square while square > 1000

- 정규표현식
	- Pattern
    	- (/pattern/)
        - /Perl|Python/ => Perl or Python
        - /P(erl|ython)/ => Perl or Python
        - /ab+c/ => a 와 1개 이상의 b 그리고 c
        - /ab*c/ => aㅇ와 b가 없거나 여러개, 그리고 c
        - 문자 그룹 \s 공백문자(space, tab, newline), \d 숫자, \w 일반적인문자,
            ',' 아무 글자나 한 글자
            ex)
             /\d\d:\d\d:\d\d/ # 12:34:56 형태의 시간
            /Perl.*Python/ # Perl, 0개 이상의 문자들, 그리고 Python
            /Perl Python/ # Perl, 공백, Python
            /Perl *Python/ # Perl, 0개 이상의 공백, 그리고 Python
            /Perl +Python/ # Perl, 1개 이상의 공백, 그리고 Python
            /Perl\s+Python/ # Perl, 1개 이상의 공백 문자, 그리고 Python
            /Ruby (Perl|Python)/ # Ruby, 공백, 그리고 Perl 이나 Python 중하나

	- Match
        - =~ 특정 문자열이 정규표현식과 매치되는지 검사
            패턴이 발견되면 첫 위치를 반환, 아니면 nil 반환
            if line =~ /Perl|Python/
            puts “스크립트 언어에 대한 언급: #{line}“
            end
	- 치환
		- line.sub(/Perl/, ‘Ruby‘) # 처음 나오는 ‘Perl‘을 ‘Ruby‘로치환
		- line.gsub(/Python/, ‘Ruby‘) # 모든 ‘Python‘을 ‘Ruby‘로치환
		- line.gsub( /Perl|Python/, ‘Ruby‘ ) # 문자열에서 Perl 과 Python을 모두 Ruby로치환

- 표준 입출력
	- STDIN. STDOUT, STDERR
<<<<<<< HEAD
	- STDOUT.puts "Hello", STDERR.puts("Error")
=======
	- STDOUT.puts "Hello", STDERR.puts("Error").
>>>>>>> test2

- 명령줄 인수
	- ARGV라는 특수한 배열에 저장된다
	- ARGV[0] 형식으로 호출

- Block
	- 이름이 없는 메소드라고 생각할 수 있다
	- 하나의 문(statement)만 가지면, {}를, 둘 이상이라면 do end를 사용


	- ex) >> [2, 10, 8, 26, 32].all? {|num| num%2 == 0}
			=> true
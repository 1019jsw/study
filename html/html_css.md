## HTML, CSS

###1. Makup 이란

####	Markup에 대한 기본개념 이해
           문서의 및 데이터의 구조를 표현하는 것
           
####    Markup 언어
    	 - HTML : 문서의 구조를 기술하는 언어
    	 - XML : 문서와 데이터에 필요한 요소를 자유롭게 정의
    	 - XHTML : HTML을 XML 형태를 빌어 재구축한 언어
    	 	HTML에서 파생되어서 나온 것
			하지만 HTML의 상위버전이다 하위버전이다 
            라고 할수없다            
            XHTML 2.0, HTML 5 => HTML 5으로 합쳐졌다

###2. HTML의 구조
    <!DOCTYPE HTML버전정보>
    <html>
        <head>
            화면에 표시되지는 않음
            문서의 제목과 메타정보를 포함
            <title>
            </ttitle>
        </head>
        <body>
            문서 콘텐츠를 담은 영역
        </body>
    </html>

####    HTML 구성
    <a href="http://www.daum.net"><Daum></a>
    	- a=> 요소(Element)
    	- href => 속성(Attribute)
    	- "http://www.daum.net" => 값(Value)

    HTML 주석 표기 <!-- -->으로 둘러싼다
    주로 기능 설명 및 주의 사항을 위해 사용한다.
        
###3. DTD
     DTD를 선언하지 않는면 호환모드(Quirks mode)로 
     웹페이지를 해석해서 화면표시를 한다.
     
     웹브라우저들마다 Quirks mode일 때 
     화면을 표시하는 방법이 달라서 
     문서형을 선언하지 않으면 브라우저 호환성을 확보하기 어렵다
     
     DTD 선언은 다양한 환경에서 상호 운용성을 보장하기 위한 첫걸음이다
        
      유효성 검사(Validation) 의 기준
      (X)Html 유효성 검사(Markup Validation)
      W3C Markup Validation Service
      
      (X)HTML DTD
      Strict : 선언된 HTML 버전의 문법과 구조를 정확하게 사용
      Transitional : 과도기적으로 사용하기 위한 선언으로 strict보다 유연
      Frameset : Transitional 속성과 더불어 frameset(iframe, frame)을 지원
      
      HTML vs XHTML
      XHTML : markup 언어의 namespace를 이용 할 수있지만 거의 쓰지 않는다..
      
####      HTML에서 XHTML로의 전환 방법
          1. XHTML DTD를 선언한다.
          2 XML 네임스페이스와 언어코드를 지정한다.
          3. 모든 시작태그는 종료태그들을 가져야한다. 또, 빈 요소의 경우 하나의 공백문자와 '/>' 로 끝나야한다
          4. 모든 요소와 속성은 소문자로 작성되어야 한다.
          5. 모든 속성값들은 큰 따옴표로 둘러싸고 값을 가져야한다.
          6. 중첩관계가 적절해야 한다.
          7. text나 URL, script에 포함된 특수문자('<', '>', '&')는 escape 시킨다.
      
####      블록 요소 vs 인라인 요소
      	- 블록 요소 : 위에서 아래로 쌓이는 것
      	- 인라인 요소 : 텍스트를 포함
      	- img는 하나의 문자로 보기때문에 인라인으로 본다
      
      인라인 요소는 블럭요소를 포함 할수 없다.
      <a><h1></h1></a> =>	X
      <h1><a></a></h1> =>	O
      
###4. HTML 요소와 주요속성
####	title
    	- 문서의 제목
        - head 요소 안에 정의
        - 검색 엔진은 문서 제목에 가중치를 둔다.
        - 스크린 리더기에서 문서 title을 가장 먼저 읽기에 접근성 측면에도 중요하다.
        
####	타이틀과 메타데이터
    	- head 요소 안에 정의
        - 문서에 직접적으로 표시(X)
        - machine(브라우저나 검색엔증 등)에 문서정보(metadata)를 제공
        - 문자코드, 마임(MIME)타입, 설명문, 키워드 등을 기술
        
####    제목, 분산, 구분선
#####    	1. h1 ~ h6 (heading tag)
            - 문서내부의 콘텐츠 제목을 정의하는 요소
            - 1~6 까지 여섯 단계로, 순서에 맞게 작성 ex) h1 다음에 h3 (x)
            - 가급적 h1요소는 문서에 한번만 사용
        
#####        2. P
        	- 텍스트 문단 요소
            - 블록요소(인라인 요소와 텍스트를 포함하는 블록 요소지만 또다른 블록 요소를 포함 할 수는 없다)
            
#####        3. br
        	- 개행 요소
            - 빈 요소(종료 태그가 필요없음)
            - br 요소를 여러 번 사용하여 행 간격을 늘이는 것은 가능하지만, 시각 효과를 위해서 사용하지 않는다.
            
#####    	4. hr
        	- css를 이용할 수 없는 환경에서 hr 요소로 내용을 구분할 수 있다.
            - 문서 내에 구분선을 표시한다.
            - 블록 요소이지만, 빈 요소이기에 종료 태그가 필요없다.
            
####	목록과 표
#####        1. ul, ol, li
            - 일반적인 목록을 구성하는 요소
            - 블록요소

            - ul
                1. 항목의 순서를 따지지 않고 목록 나열(unordered list)
                2. bulleted list
                3. li만 포함가능

            - ol
                1. 항목의 순서대로 목록 나열(ordered list)
                2. numberical or alphabetical list
                3. li만 포함가능

            - li
                1. 목록에 포함되는 항목(list item)
                2. 대부분의 브라우저에서 들여쓰기가 된다.
                
#####		2. dl, dt, dd        
        	- 정의형 목록 구성
            - 용어 정의와 설명 외에 참고문서, 링크와 설명 등 다양한 용도로 이용될 수 있다
            
            - dl
            	1. 정의형 항목의 목록 나열(definition list)
                2. 블록 요소
                3. dt 요소와 dd 요소만 포함 가능
                
            - dt
            	1. 정의형 항목의 용어(definition term)
                2. 인라인 요소
                3. 인라인 요소와 텍스트를 포함
                
            - dd
            	1. 정의형 항목의 설명(definition description)
                2. 블록 요소
                3. 인라인 요소와 텍스트, 또 다른 블록 요소를 포함
                4. 대부분의 브라우저에서 들여쓰기 되어 표시됨
                5. 여러 개의 dd도 가능
                
              <dl>
              	<dt>
                	<dd></dd>
                </dt>
              </dl>
              
#####		3. table
        	- 표를 작성하는 요소
            - 셀, 행, 열
            - table 요소를 레이아웃 용도로 사용하지 않는다.
        	
            - caption
            	1. 표 제목을 지정하는 요소
                2. 표 위에 중앙 정렬로 표시
            
            - thead, tfoot, tbody
            	1. 행 그룹화를 위한 요소
                2. thead : 표의 머리글 / tfoot : 바닥글 / tbody : 본문
                3. 인쇄할 때 표가 여러 페이지에 걸친 경우 모든 페이지에 헤더행과 푸터행이 반복해서 출력됨
                4. tfoot 는 thead 요소 뒤에 기술되지만, 표 가장 하단에 출력
                
            - colgroup
            	1. 표의 열을 그룹화하기 위한 요소
                2. table 혹은 caption 요소의 바로뒤 (thead, tfoot, tbody 요소보다 앞)에 지정
                3. 열의 구조적인 그룹화하기 위해 사용
                
            - col
                - 열을 그룹화하여 공통 속성 및 스타일을 적용
                - class를 지정하여 스타일을 공유, 하지만 IE에서는 대부분 스타일 지정이 가능하지만
                Firefox, Chrome 등에서는 border, background, width만 가능
                    
#####	링크, 이미지, 이미지맵
    	1. a
        	- 텍스트에 링크를 설정하는 요소이다
            - 인라인 요소(텍스트를 포함)
            - a 요소의 href 속성값에 #name(id) 속성값을 지정하면
            name과 id 속성으로 지정된 문서 내 특정 위치를 이동한다.
            
            주요속성
            	- href : 링크 주소 지정
                - name, id : 앵커 식별자 지정
                - title : 링크의 보충정보를 표시, 대부분의 브라우저에서 title속성에 지정한 값이
                툴팁으로 표시
                - target : 링크된 문서를 어떤 창에 열 것인지 지정
                	_black: 새창, _parent, _top, framename(기본 : self)
                    
		2. img
        	- 이미지를 삽입하는 요소
            - 인라인 요소지만, 빈 요소(종료태그 필요없음)
            
            주요속성
            	- alt : 이미지에 대한 설명
                - width, height : 기본적으로는 이미 사이즈 만큼..., 페이지 로딩 진행시 이미지의 가로/세로 크기만큼 영역을 확보
                - longdesc : 자세한 이미지 설명이 있는 페이지 경로를 지정 alt에 전부 기술을 못할때 사용
                - src : 이미지가 어디있는지 지정
                
         3. map
         	- 이미지맵을 정의하기 위한 요소
            - 검색 참조...
            
#####	텍스트
    	1. em
        	- 일반적인 강조, 이텔릭체로 표시
            
        2. strong
            - 더욱 강한 강조, 볼드체로 표시
            
#####	그룹
    	1. div
        	- 블록 요소
        
        2. span
            - 인라인 요소
       	
#####	폼
    	- 폼의 최상위 요소로 폼을 구성
        
        주요 속성
        	- action : 폼을 전송할 URL지정
            - method : 폼의 데이터를 전송하는 방법
            	1. get : url ? 뒤에 파라미터 값을 붙여 전송
                2. post : http 헤더에 숨겨져 서버로 전송, 일정 크기 이상의 데이터 전송 시 사용
                
            - input : 폼 안에 기본적인 컨트롤 생성
            	input type="image" (src 속성과 alt 속성 지정) : 이미지를 버튼처럼 사용하는..
                disabled : 데이터로 서버로 전송하지 않음
                readonly : 데이터로 서버로 전송함
                
            - textarea, select, option
            - button : 이미지나 텍스트 등을 포함할 수있어 유연하게 활용할 수 있다
            - label : for속성으로 id와 매칭 시킨다, for는 유니크한 속성이 아니라서
            여러개를 두어서 한곳이 선택 되도록 할수도 있다.
            - fieldset : 필수항목영역 같이 항목을 나누어줄때 사용한다, 폼안에 fieldset, legend는 한개 이상 나와야한다.
            - legend : fieldset에 대한 타이틀, fieldset요소 뒤에 한개만 나온다
            
	시멘틱 마크업(Semantic Markup)
    	- 콘텐츠에 가장 적합한 의미의 HTML코드를 부여
            
### 5. CSS
####	SELECTOR
    	1. 타입선택자
			- 동일한 속성을 콤마로 구분하여 선정
            
        2.  ID, Class 선택자
        	- id는 #id 로 구분
            - class는 .으로 구분

		3. 유사클래스 선택자
        	- 해당 엘리먼트 상태에 따라 구분짓는 선택자로 HTML문서엔 없느나 CSS에선 존재하는 것 처럼 작성
            IE6에선 a(Anchor) Tag에만 지정이 가능하며 그 외 브라우저는 지원여부가 조금씩 다름
        	- a:link{color : blue;}
            - a:hover {color : red;}
            - a:visited {color : blue;}
            - a:active {color : blue;}
            
####	선택자의 조합
    	1. 하위 선택자
        	- ul li {}
            - .list_item .first {}
            
        2. 자식 선택자
        	- ul > li {}	(ul의 자식들)
           
        3. 인접 선택자   
			- ul + ol {}	(ul 에 인접한 ol들만)
            
####	선택자의 우선순위
    	- 스타일 선언이 위에서 순차적으로 적용이 되고
        마지막에 선언된 스타일이 우선순위를 갖는다
	
    	ex)	
        <style type="text/css">
        	.tit_name {color : red;}
            h3 {color : green;}
            #titName {color : blue;}
        </style>
        
        <h3 id="titName" class="tit_name" style="color:yellow;">타이틀 제목</h3>
        
        in-line > id > class > type
        
        style 뒤에 공백 후 !important를 추가하면 우선적으로 적용된다
        
        - in-line 방식
        	- 특이한 사항이 아니면 안쓴다
            
        - internal 방식
        	- head 안에 넣는것
            
        - External 방식
        	- css를 따로 파일로 저장하여 불러오는 방식
            
####	CSS 수치단위
    	- em, % (상대단위)
        	- 브라우저의 기본 글꼴을 기준
            - 현재 엘리먼트가 상속받는 글꼴 크기 변화에 따라 유동적
            
            ex) 
            .wrap {font-size:2em}
            .wrap p {font-size:1em}
            
            <div class="wrap">
            	바깥영역
                <p>안쪽영역</p>
            </div>
            
            p 태그의 1em의 기준은 바깥에 wrap 2em을 기준으로 1em만큼이다
            
        - px, pt (절대단위)
        	- 모니터의 1픽셀
            
        상대단위를 사용하면 접근성이 향상되나, 단위 환산의 어려움과
        스타일 수정 시 다양한 환경에서 일관적이지 못한 화면을 나타낼 문제가 있음
        
####	FONT
    	글자와 관련된 스타일을 지정할 수 있는 속성
        
        - text-indent : 글자를 들여쓰거나 내여쓸때 사용 (10px, -10px)
        - text-decoration : 윗줄, 밑줄, 중간줄 적용시 사용
        
####    Padding & margin
    
        - padding : 안쪽 여백	우px, 아px, 왼px, 위px
        - margin : 바깥쪽 여백	우px, 아px, 왼px, 위px
        - margin > border > padding> content
        
        - margin 병합 : 작은px이 큰px로 병합된다
        - margin으로 중앙정렬 : {margin:20px auto};

####	BACKGROUND
    	- background-color : transparent(투명)
    	- background-repeat : no-repeat (하나만)
        	repeat-x (가로로 반복),  repeat-x (세로로 반복), repeat(바둑판 형식으로 반복)
            
####	DISPLAY
    	- display : none : 화면에서 안보이게
        - display : block : block형태로 보이게
        - display : inline-block : 블럭이 속성 width, height, margin, padding 을 사용할 수 있는 속성
        
        - overflow : visible (기본) 영역밖으로 넘어가도 그냥 보여주는 것
        - overflow : hidden 넘어가는 부분은 잘라서 보여줘라
        - overflow : scroll 넘어가는 부분은 해당부분에 스크롤을 제공
        - overflow : auto 넘어가지 않으면 visible 형태로 보여주고 넘어가면 scroll을 제공
        
        - overflow-x:hidden, overflow-y:auto => 가로에 대해서는 잘라서 보여주고 세로에 대해서는 스크롤을 제공
        
####	FLOAT
    	- 엘리먼트를 block 형태로 부유시킬때 사용(display:block을 사용안해도)
        - block 형태로 특정방향(left, right)으로 정렬
        
        - float : inherit  (기본 : 밖의 float 속성을 상속받음)
        - float : left
        - float : right
        - float : none
        
####	CLEAR
    	- 이전 엘리먼트의 float값을 상속받아 같은 방향으로 정렬되는 현상을 막기위해 사용
    
####    POSITION
    	- float과는 다르게 왼쪽, 오른쪽 정렬하는 형태가 아닌, 위치하는 곳에 대한 값(오프셋)을 지정
        
        - position : static (기본, offset을 가지지 않음)
        - position : relative (상대적, 원래 위치를 기준)
        - position : absolute (절대적, 부모위치를 기준) 단, 원래있던 위치는 사라져서 그 영역에 다른 엘리먼트가 차지한다.
        부모위치가 없다면 화면 좌측 상단을 기분으로 움직인다.
        - position : fixed (화면에서 고정, ie6 지원 불가) 화면의 좌측 상단을 기준으로 움직인다.
        
####    Z-INDEX
    	- 엘리먼트의 입체적인 순서를 정의
        - 수치가 작을수록 아래쪽에 있다는 것을 의미
        - z-index가 높아서 상위(부모)엘리먼트끼리의 수치가 낮으면 아래쪽에 위치한다.

######	FLOAT Example
| BOX 1  |
|----------|
| BOX 2  |
| BOX 3  |

==BOX 1에 float : right 를 준다면==

| BOX 2  | BOX 1  |
|----------|
| BOX 3  |

BOX 1이 오른쪽으로 분리되고 BOX2가 1번자리로 치로 올라간다

==BOX 1에 float : left 를 준다면==

| BOX 1  |
|----------|
| BOX 3  |

BOX 1이 block으로 붕뜨기 때문에 BOX2번과 겹치게 된다

### 6. CSS의 효율적인 활용
####	레이아웃
    	- 사전적의미 : 책이나 신문, 잡지에서 글이나 그림등을 효과적으로 정리하고 배치하는 일.
        - Header : 사이트정보, 메인메뉴, 로고이미지
        - Nav : 메뉴 또는 링크 정보
        - content : 본문 내용
        - side : 본문 이외에 주변에 배치할 내용
        - Footer : 사이트 정보 및 부가 정보
        
        * clear : both; 로 float을 해제하는게 가장 명확한 방법이다

####	이미지와 성능과의 관계
    	- 이미지 조각이 많을 수록 총 용량 증가
        - 여러 이미지를 하나의 이미지로 합친 후 필요한 부분을 background-position으로 구현(CSS- SPRITES)
        
####     IR
     	- image Replacement(IR)
        - 의미가 포함되어 있는 이미지를 배경으로 처리하고 이에 상용하는 텍스트를 넣는 방법
        - CSS Sprites 기법과 함께 사용
        - Daum 탑 예시
        

### 7. HTML5 & CSS3
####	HTML5란
    	- HTML 4, XHTML 1의 새로운 버전의 핵심 마크업 단어
        - 플래시나 실버라이트와 같은 플러그인 기반의 인터넷 어플리케이션에 대한 필요를 줄이는데 목적
        - 보다 쉬운 웹개발과 핸들링
        
	DOCTYPE 선언
    	<!doctype html>
        <html>
        	<head>
            	<meta charset="UTF-8">
                <title></title>
            </head>
             <body>
             </body>
		</html>
       
###### 시멘틱 마크업


####	1. 구조 요소
    	- <section> : 문서의 특정 영역을 구분
        - <header> : 문서 또는 영역의 머리말에 해당하는 내용 구분
        - <footer> : 문서 또는 영역의 꼬리말에 해당하는 내용 구분
        - <nav> : 다른 페이지를 가리키는 링크들의 모음(네비게이션) 구분
        - <article> : 하나의 글 또는 기사(본문)의 단위 구분
        
####    2. 블럭 요소
    	- <aside> : 본문의 흐름에서 벗어나는 내용 구분(참고, 팁, 사이드바, 인용)
        - <figure> : 이미지, 비디오 등에 자막(캡션) 표현
        - <dialog> : 사람 간에 일어난 대화 영역 구분
    
####    3. 인라인 요소
    	- <mark> : 강조할 필요까진 없으나 주목해야 할 문구를 표현(형광펜)
        - <meter> : 특정한 범위에 속하는 숫자 값을 표현(월급, 득표율, 테스트 점수 등)
        - <time> : 특정한 시각을 표현
        - <progress> : 현재 진행 중인 상태를 표현(다운로드 완료율)
        
####    4. 미디어 요소
    	- <video> : 별도의 플러그인 설치를 필요로 하지 않는 동영상 자료를 표시(UI API 제공)
        - <audio> : 별도의 플러그인 설치를 필요로 하지 않는 음원 자료를 표시(UI API 제공)
        
####	5. 상호작용 요소
    	- <details> : 추가적인 상세정보를 담고있는 영역(툴팁의 내용)
        - <datagrid> : 동적인 데이터를 효과적으로 표현(트리, 목록, 표)
        - <menu>, <command> : menu는 command 요소를 표함하여 즉각적인 동작 발생(콘텍스트 메뉴)
        
####    6. HTML 5에서 사라진 요소
    	- acronym, applet, basefont, big, center, dir, font, frame, frameset,
        isindex, noframes, noscript, s, strike, tt, u
        
        - Time(날짜, 시간)
        	<time>5:35 P.M on April 23rd</time>
            
        - Meter(계량)
        	<meter>60%</meter>, <meter>3/5</meter>
            
        - Progeress(진행상태)
        	<progress value="1534602" max="4603807">33%</progress>
            
####	편리한 웹폼
    	- <input type="search"> : 검색박스
        - <input type="number"> : 숫자를 위한 input
        - <input type="range"> : 슬라이드
        - <input type="color"> : color picker
        - <input type="tel"> : 전화번호
        - <input type="url"> : 웹 URL 주소
        - <input type="email"> : 이메일 주소
        - <input type="date"> : 달력 표시 및 날짜 선택
        - <input type="month"> : 월
        - <input type="week"> : 주
        - <input type="time"> : 타임스탬프
        - <input type="datetime"> : date+time stamps
        - <input type="datetime-local"> : 지역 날짜와 시간
        - <canvas> : Graphics 지원을 위한 Canvas 제공
        - <video & audio> : 표준 codec 기반의 비디오, 오디오 재생 환경 내장
        
        - <Local storage /DB 지원>
        	- Session Storage와 Local Storage 를 제공
            	- Session Storage
                	현재 열린 창에서 사용될 수 있는 session data를 저장
                - Local Storage
                	다수의 창 간에 사용될 수 있는 특정 도메인 데이터 저장

		- <Geolocation API 지원> : 위치정보 : 위도, 경도, 높이, 정확도, 진행방향, 진행속도를 
        브라우저에서 Script API를 통해 제공
        - <Web Worker를 통한 백그라운드 프로세스 지원> : 멀티프로세스 지원으로 인해 효율적인 task 처리 가능
        	
    구형브라우저 자체가 해당 태그를 지원을 하지 않는다
    
### 8. CSS3
	Border Radius
    	- 모서리를 둥글게 만들어준다
    
    Box Shadow & Test Shadow
    	- 그림자를 만들어주는 옵션
        
    RGBA에 투명도를 설정하는 옵션이 추가되었다
    
    @Font-Face
    	- 웹폰트 기능..브라우저 마다 지원하는게 각자달라서 ttf인지 eot인지 구분을 해야한다
        
	Text-Overflow
    	- text가 너무 긴 경우 ..으로 처리해주는 옵션
        
	Gradients
    	- background : -gradient 옵션을 사용하여 그라데이션을 만든다
    
    Transitions
    	- margin-left,  margin-right가 변경될때 스무스하게 움직인다
        
    Transforms
    	- rotate, scaleX, translate3d, perspective 등을 이용해서 변화한다
        
    Animations
    	- pulse를 통해 애니메이션을 걸어두고 from, to를 사용하여 애니메이션 효과가 나타나다.
        
	CSS3 Selectors
    	- :first-child(가상선택자)
        - :nth-child(순차적 자식 가장 선택자)
        - w3c reference 참조
        
### 9. Dough UI framework
	class에 type 기타등등으로 조합하여 입력하면 조합한 것에 해당하는 UI를 만들어준다.
    기타 가이드 참조...
    
## Index의 구조

	B*Tree Index의 구조 (B는 Balanced의 약자)

	트리형식의 구조 Root Node, Branch Node, Leaf Node로 구성되어있다

    

## Index의 생성 목적

	책의 목차의 페이지 번호 와 정렬이 되어있다 마찬가지로 검색과 정렬이 목적이다

    

### Index Scan (operation)의 종류

- Index Unique Scan

	- 단 하나의 RowId만 추출한다.

    - Index가 Promary Key이거나 Unique Index로 생성되 있어야 한다.

    - Index를 구성 한 모든 컬럼에 '='로 비교되야 한다.

    만약 일부 선행 컬럼에만 조건이 부여되면 Index Range Scan으로 변경된다.

    

    - Root 블록 -> Branch 블록 -> 해당 Leaf 블록 순으로 액세스한다.



	file

    

- Index Range Scan

	- 가장 보편적인 액세스 형태로 하나 이상의 RowId를 추출한다.

	- 주로 Non Unique 인덱스에서 발생하지만 Unique Index에서도 발생 가능하다.

	- Index의 선행 컬럼에 조건이 부여 되어야 한다.

		- 비교 연산자 : =, <, <=, >, >=, between, like 등

		- like 의 경우 퍼센트가 뒤쪽에 와야만 Index를 탄다..

	- 스캔 범위가 넓어지면 RowId를 통한 테이블의 Random I/O가 증가되어 부담이 된다.



- Index Range Scan Descending

	- Index Range Scan과 동작 방식은 동일하나 역순으로 데이터를 액세스한다.

	- 가장 최근 데이터를 조회할 때 많이 사용한다

		- 예) 게시판, 이력 데이터 등

	- SQL에서 Index 구성 칼럼에 맞게 order by ... desc를 하거나 명시적으로 index_desc 힌트를 사용할 때 나타난다.



- Index Full Scan

	- Index의 Leaf Block 전체를 읽는 다는 것을 제외하면 Index Range Scan과 동일하다

	- 힌트로 제어가 불가능하다.

	- Index Full Scan의 전제 조건

		- SQL에 사용된 모든 컬럼이 그 Index에 존재해야 한다.

		- Index 컬럼 중 최소한 not null 컬럼이 하나라도 존재해야 한다.

			- 이유는 Index 엔트리에 null값은 포함되지 않기 때문이다



- Index Fast Full Scan (Oracle)

	- Table Full Scan의 Index 버전이다,

	- SQL에 사용된 컬럼이 모두 Index에 포함되어 있을 경우 적용

		- Not null 조건이 포함된 컬럼이 Index에 하나 이상 존재해야 한다.

		- Index 세그머트를 HWM까지 읽으면서 Leaf Block에 존재 하는 Key 값만 추출한다.

	- Multi Block I/O가 일어나고, 병렬 처리가 가능하다 그렇기 때문에 정렬이 되지 않는다 

	  대신 속도는 Index Full Scan보다 빠르다.

	- index_ffs, parallel_index 힌트를 사용하면 된다



- Table Full Scan

	-  테이블 세그먼트의 HWM(물이 어디까지 찼었다 라는 표시)까지 Access한다

		- 데이터 존재 여부와 관계없음

	- Multi Block I/O가 발생한다.

	- DB_FILE_MULTIBLOCK_READ_COUNT Parameter로 한번에 읽어 들일 Block의 수를 정한다

	- Table Full Scan을 적용해야 하는 경우

		-  적용 가능한 Index가 없을때

		-  넓은 범위의 데이터를 Access 해야 할 때

		-  아주 소량의 테이블일 때



### Index를 이용한 Data Access

- Oracle과 MySQL(InnoDB)의 차이

- Oracle은 테이블 고유의 식별번호(RowId)를 있기 때문에 Index의 RowId로 테이블의 RowId로 찾아간다

- MySQL은 Index의 PrimaryKey로 테이블의 PrimaryKey로 찾아간다



- MySQL InnoDB 테이블

    - Clustering Table 형태

    - Oracle의 IOT(Index Organized Table)과 유사

    - 다른 Index에 비해 PK를 통한 access가 가장 빠름

- MySQL InnoDB 테이블의 Clustering Key 값 선정 순서

    - 명시적으로 선언한 Primary Key

    - 첫 번째 Unique Index

    - 내부적으로 정한 임의의 값



### Join의 종류

- Nested Loop Join

    - 현실적으로 가장 많이 적용되는 기본적인 조인

    - 순차적으로 처리되며 먼저 수행되는 집합의 처리범위가 전체의 일의 양을 좌우한다.

    - Random Access 방식으로 대량의 범위 조인 시 부하를 줄 수 있다.

    - 두 테이블을 Outer (Driving) Table (선행테이블)과 Inner Table (후행테이블)이라고 불린다.

    - use_nl 힌트를 사용하여 유도할 수 있다.

    - file

- Sort Merge Join

    - 동시에 각각의 테이블이 자신의 처리 범위를 액세스 한다.

    - 조인의 방향과는 상관 없다

    - 필요에 따라 Sorting 작업이 발생하며, 일반적으로 배치작업 같이 처리량이 많은 경우에 주로 사용된다.

    - 두 테이블을 First Table, Second Table 이라고 한다.

    - use_merge 힌트로 유도한다.

    - file

- Hash Join

    - Hash 함수를 사용하여 조인을 수행하는 기법

    - Nested Loop와 Sort Merge 조인의 단점을 보완한다.

        - Nested Loop 조인 시 스캔 범위가 넓어질 때 랜덤 액세스의 부담이 있을 경우 사용한다.

        - Sort Merge 조인 시 대량 데이터의 정렬 작업에 대한 부담을 해결하기 위해 등장하게 되었다

    - 조인되는 두 테이블을 Build Table, Probe Table이라 불린다

    - use_hash 힌트를 사용하여 유도할 수 있다.

    - file

- Semi Join

- Outer Join

- Cartesian Join

- Index Join



### Sort 연산 (operation) 종류

- Sort Group By / Hash Group By (10g)

    - group by를 사용한 구문에서 발생

- Sort Unique

    - 유일한 집합을 생성할 경우 (in 절, 집합연산, distinct)

- Sort Order By

    - order by 절을 사용했을 때

- Window Sort

    - Analytic Function 사용 시 (rank() over, sum(), over)



### Index Scan의 (Cost) 결정 요소

- Clustering Factor

- Index Height (또는 Depth)

- Index와 테이블의 선택도 (Selectivity)

    - 읽어야 할 총 Block의 수



### Clustering Factor 란

- Clustering Factor란 Index의 Table에 대한 정렬 정도이며

    Index를 경유한 Table Lookup의 비용을 예측하는데 사용된다.

- Table의 Row가 Index Key에 대해 얼마나 비슷한 순서로 저장되어 있는가를 나타내는 정도

- Index Key에 해당하는 Table Block을 매번 새로 읽어야 하는 회수



- Clustering Factor와 Index

- 좋은 Index는 낮은 Clustering Factor 값을 갖고,

    나쁜 Index는 높은 Clustering Factor 값을 갖는다.

    - User_indexes의 Clustering_Factor 컬럼을 조회해서 확인할 수 있다.

- Index에 대해 테이블에 있는 데이터가 서로 잘 모여 있으면 비용(Cost)이 낮아져 Index 사용을 선호한다.



- Clustering Factor와 성능

	- Index Scan의 Cost에 영향을 준다.

		- Clustering Factor가 우수할 때는 Index Scan을 선택하고

		- Clustering Factor가 불량할 때는 Table Full Scan을 선택한다 (Selectivity가 낮은 경우에도 가능성이 있다)

	- Index를 통해 Data를 읽을 경우 해당 SQL의 전체 일의 양을 결정한다.

		- 정렬 작업을 할 때 Clustering Factor가 매우 불량하다면

			Index Scan보다 Table Full Scan과 Order By를 사용하는 것이 오히려 유리할 수 있다



- Clustering Factor의 개선방법

	- Index Rebuild로는 근복적으로 해결되지 않는다

	- Table을 재구성하는 것이 유일한 방법이다.

		- Index의 구성 컬럼 순으로 테이블을 재구성한다.

		- 특정 Index에 대한 Clustering Factor가 좋아 질 수 있으나,

			다른 Index의 Clustering Factor에 영향을 줄 수 있다.

            

### Oracle Optimizer와 실행계획

- Oracle Optimizer의 특징

    - Optimizer의 SQL 처리 단계

    	- 1단계. 표현식 및 조건의 평가
    		- SQL의 표현식과 상수를 가지고 있는 조건을 먼저 평가(계산 및 단순화)한다.

    	- 2단계. SQL문 변형
    		- Subquery나 Inline View 등이 섞여 있는 복잡한 SQL문에 대해 간결한 문장으로 변경한다.
    		- 
		- 3단계. Optimizer 모드 선택
			- 규칙기준(RBO) 또는 비용기준(CBO) 액세스 방법을 선택하여 최적화의 목표를 결정한다.

        - 4단계. Access경로 선택
        	- 각 테이블에 대해 이용 가능한 Access 경로를 하나 또는 그이상 선택한다. (Index Scan, Full Scan 등)

        - 5단계. Join 순서 선택
        	- 두 테이블간의 Join 순서를 결정한다.

        - 6단계. Join 방법의 선택
        	- Nested Loop, Hash, Sort Merge

- Cost의 개념과 통계정보

    - RBO (Rule-Based Optimizer) 지금은 거의 쓰지않는다
    	- Oracle 9i까지 사용되고 10g부터는 더 이상 지원하지 않고 기능만 남아있다.
		- 미리 정해져 있는 공식에 의해 실행 방법이 결정된다.

			- Index 구조나 비교 연산자에 따라 순위를 부여하여 최적의 경로를 결정한다.
			- SQL을 실행하기 위한 방법이 하나 이상이라면, 랭킹이 높은 Operation을 사용한다.
			- Optimizer의 판단이 규칙적이어서 정확한 예측이 가능하다.

	- CBO (Cost-Based Optimizer)
		-  실제로 가장 빠르게 실행되는 방법의 Cost 계산
		-  최적화를 위해 가장 적은 비용으로 SQL의 결과를 추출해내는 실행계획을 만든다.
		-  다양한 통계정보를 참조한다.
			-  Row수, Block수, Block당 평균 Row수, Row의 평균길이, 컬럼 별 상수 값의 종류 및 분포도, 
				Clustering Factor, 인덱스 깊이, Index Leaf Block수

		- 주요 구성요소
			- 실행 계획 생성, 각 실행 계획 평가, 저비용 실행 계획 선택

	- CBO의 실행 계획 선택

		- 가장 작은 Cost를 선택
		- file
		- file
		- Optimization 오버헤드
			- Join 하는 Table이 많아지면 Optimization이 필요한 SQL문장의 경우의 수가 많아져 오버헤드가 발생한다.
			- Optimizer는 어느 정도 경우의 수에 대한 Cost 연산 후 더 이상 Cost 연산을 진행하지 않는다. ->Cutoff !!
			- 경우에 따라서 가장 최적의 Cost 연산을 놓치는 경우가 발생해서 최적의 실행 계획을 세우지 못할 때가 있다.
			- Default : 2,000개 (9i)

	- CBO의 실행 계획 선택

		- Hint를 통한 Optimizer 제어
			- Optimizer의 한계를 보완하기 위해 사용한다.
			- Optimizer가 최적의 실행 계획을 수립하지 못할 경우 Hint를 이용해서 유도한다.
			- 단, 외부 환경의 변경 가능성이 있기 때문에 Hint 사용이 오히려 최적의 실행 계획 수립을 방해 할 수도 있다.
				- 테이블이나 Index의 변경, 통계 정보의 변경 등

	- Cost의 정의
		- Optimizer가 SQL을 실행하는데 필요한 시간의 예측값
		- Cost는 I/O가 아니라 Query의 수행 시간(Time)이다

	- Time으로서의 Cost
		- Total Time = CPU Time + I/O Time + Wait Time
			- 여기서 Wait Time은 쿼리를 실행하는 수행절차가 일어나게 되는데 수행단계가 넘어가기 전에 대기하는 시간이다
				예측 불가능하므로 제외한다.

	- CBO를 이해하기 위한 기본용어

		- 카디널리티(Cardinality)
			- 집합의 크기, 집합에 속하는 원소의 수
		- 선택도(Selectivity)
			- 특정 조건(Predicate)에 만족할 확률(Row의 비율)로 Where조건에 따라 값이 변경된다.			 
        - 히스토그램(Histogram)
        	- 막대 그래프, 컬럼에 있는 값들의 실제 분포도

        	- Data가 비대칭적(Skewed)일 때 그 분포를 알 수 있는 유일한 방법이다.

	- 통계 정보의 수집

		- CBO가 사용하는 주요 통계 정보의 종류
			- Table 통계 : Row 수, Block 수, 평균 Row 길이
			- Column 통계 : 칼럼의 NDV 값(유니크한 값들의 개수), 컬럼의 null 값이 수, 데이터의 분산정도(Histogram)
			- Index 통계 : Leaf Block 수, Index Level(Depth), Clustering Factor
			- System 통계 : I/O 성능,  CPU 성능

		- DBMS_STAT 패키지를 이용하면 통계 정보를 수집, 변경, 삭제 등이 가능하다
			- GATHER_DATABASE_STATS
			- GATHER_SCHEMA_STATS
			- GATHER_TABLE_STATS
			- GATHER_INDEX_STATS
			- GATHER_SYSTEM_STATS
			10g는 scheduler에 의해 매일 정해진 시간에 자동으로 통계 수집 작업이 진행된다.

	선택도 개념의 이해 좋은 예)

	분포도(selectivity)가 좋다(우수하다)는 것은 서로 다른 데이터 값들이 중복없이 존재 한다는 의미를 나타낸다

	우선 선택성(Selectivity)란 전체 행수(데이터건수) 분에 해당 데이터 값(중복되지않는)으로 계산한다.

	예를 들어 회원 테이블에 1만 건의 데이터가 있다고 가정하면, 회원테이블에 회원이 사는 거주지 시도구분과 회원아이디 칼럼이 있다고 하고, 회원아이디는 고유한 값을 가지기 때문에 1/100,00의 선택성(Selectivity)을 갖는 반면, 시도구분은 중복된 값이 많이 있을 수 있기 때문에(10개의 시도구분이 있고 각각 1000행씩있다면 1,000/10,000의 선택(Selectivity)을 가지게 된다. 이러한 경우, 당연히 시도구분보다는 회원아이디의 선택성이 더 좋기 때문에, 다른 조건을 무시한 채 선택성만을 가지고 인덱스를 선정한다면 시도구분보다 회원아이디가 더 좋은 인덱스 후보가 된다고 할 수 있다.



- dbms_xplan 패키지 사용하기

	- 실행 계획 확인 방법
		- Explain plan 명령
			- dbms_xplan.display
			- dbms_xplan.display_cursor

		- autotrace

		- SQL Trace (10046 Trace)

		- dbms_sqltune.report_sql_monitor (11g)
			- 실시간 모니터링 가능

	- Explain Plan 명령

		- SQL문을 분석해서 실행 계획을 수립 한 후 그 실행계획을 저장할 수 있게 하는 명령어

		- 실행 계획을 저장할 테이블은 사용자가 별도로 생성해야 한다. 일반적으로 PLAN_TABLE로 생성한다.

		- PLAN_TABLE이 제공하는 정보

			- Access 되는 테이블의 순서

			- 테이블의 Access 방법 및 Join 방법

			- Cost, Cardinality, Bytes 등의 정보

		- file

	- Explain Plan의 실행

		- 실행 계획 읽는 방법

			- 같은 수준(Depth)으로 들여쓰기가 되어 있는 두 개의 단계는, 위에 있는 문장이 먼저 수행된다

			- 들여쓰기가 많은 Access 경로는 글허지 않은 경우보다 빨리 실행된다

			- Index를 통해서 테이블을 Access 하는 것은 한 묶음으로 해석한다.

				위에서 아래로, 안에서 밖으로!!

	- DBMS_XPLAN

		- SQL의 실행 계획을 쉽게 조회하기 위한 툴이다

			- Explain plan 명령의 결과를 사용자가 출력 포맷을 설정하여 원하는 정보만 볼 수 있다.

			- V$SQL_PLAN, V$SQL_PLAN_STATISTICS_ALL에 저장되어 있는 실제 샐행 계획과 통계 정보를 확인 할 수 있다.

			- 실행 계획은 패키지 내의 3가지 함수를 통해 모두 조회가 가능하다 -> display, display_cursor, display, awr

        - 9i에서 소개되었고, 10g에서 기능이 더 강화 되었다.

    - DBMS_XPLAN.DISPLAY의 Predicate 정보

    	- Access predicate

    		- Access Type을 결정하는데 사용되는 조건이다.

    		- 실제 Block을 읽기 전에 어떤 방법으로 Block을 읽을 것인가를 결정한다는 의미다.

    		- Index Lookup이나 Join등으로 표현된다.

		- Filter Predicate

			- 실제 Block을 읽은 후 데이터를 걸러 내기 위해 (Filtering) 사용되는 조건

    - DBMS_XPLAN.DISPLAY_CURSOR

    	- Plan Statistics 정보를 조회할 수 있다.

    	- SQL의 실제 실행계획을 조회할 수 있다.

    	- 실행계획 외의 다양한 통계정보도 조회 가능하다.

    		- I/O 사용량, 메모리 사용량, 실행 시간

    		- Rows, Bytes, Cost

	- PostgreSQL 실행계획

		- Oracle과 유사한 형태를 가진다.

### Hint 사용하기

- Join 및 Index 관련 Hint의 종류

	- file

- Index 전략 및 사용상 주의사항

	- Index 대상 컬럼 선정

		- Where절의 Access 조건에 항상 또는 자주 나오면서 선택도(Selectivity)가 낮은경우

		- Join 시 대상 테이블과 조인조건(연결고리)가 될 경우

		- 특정범위의 조회나 정렬이 필요한 경우

    - Index 대상 컬럼 순서

    	- "=" 조건으로 조회되는 컬럼을 되도록 앞에 둔다 (범위검색조건(between, <, >)이 앞에 올 경우 효율성 저하)

    	- Sort Operation을 감안해서 정한다

    - 특별한 경우를 제외하고 절대로 index 컬럼을 연산하면 안된다.

    	- select * from emp where to_char(birth_date, 'yyyymm') = '198504'	(X)

    	- select * from emp where birth_date between to_date('19850401', 'yyyymmdd') and to_date('19850431', 'yyyymmdd') 	(O)

	- 데이터 타입에 주의한다.

		- 가능하면 데이터 타입에 맞춰 상수를 사용한다.

		- 숫자 타입에 문자를 바인딩 하면 문자를 숫자로 변환한다(index 컬럼을 변환하지 않기 때문에 괜찮다)

		- 문자 타입에 숫자를 바인딩 하면 문자를 숫자로 변환한다(index 컬럼이 형변환이 일어나기 때문에 좋지않다 )

	- Index와 정렬

		- 따로 정렬이 일어나지 않는 경우

        	- file

		- 정렬이 일어나는 경우

			- file

### MySQL Optimizer와 실행계획

- MySQL의 SQL 실행

	- Query cashe라는 게 있다

		- 쿼리를 날렸을 때 결과를 보관하고 있고 동일한 쿼리 요청이 오면 파싱을 거치지 않고 쿼리캐쉬에서 던저준다

		- 동일한 쿼리 조건이라는 것은 대소문자까지 전부 동일한 문자열이라는 것

		- 단점은 해당 테이블의 DLL같은 것을 열어보면 캐쉬가 날아간다

		- 같은쿼리를 읽기 전용으로 쓰는곳에 쓰이면 편하다



- MySQL의 Cost 계산

	- MySQL은 Cost-Based Optimizer를 사용한다.

	- Cost의 계산은 4KB의 Page를 읽은 수로 계산한다.

	- Cost 계산의 기초가 되는 통계자료

		- 테이블이나 Index를 이루는 Data Page 수

		- Index의 Cardinality (number of distinct value)

		- Row와 Key의 길이

	- last_query_cost라는 세션 변수로 확인 가능하다.
		- subquery나 union 같은 복답한 쿼리는 불가능

	- SQL_NO_CACHE 옵션으로 cache hit를 막은 상태에서 측정해야 한다.

- MySQL의 Join 방식
	- MySQL은 무조건 Nested Loop Join이다.
		- 단, Join buffer를 이용한 실행계획 제외

- Explain 명령
	- Select문 앞에 explain만 명시하면 된다
		- Insert, Update, Delete는 지원하지 않음
    - From절에 subquery를 포함하고 있을 경우
    	- 1단계. MySQL은 실제 그 subquery를 실행한다.
    	- 2단계. temporary table에 그 결과를 담고 난 후 outer query를 최적화 한다
    - 항상 올바른 실행 계획을 세우지는 않는다
    - Limit 절은 예측 row수를 고려하지 않는다

- Explain 명령의 확장
	- Explain extended
		- Explain의 결과에 외에 Optimizer에 의해 변형된 SQL정보를 보여준다. ("reverse compile")
		- "filtered" 정보가 추가된다
		- "show warning" 명령어를 통해 볼 수 있다.
    - Explain partitions
    	- 기존 실행계획에 "partitions" 정보가 추가된다.
    	- Partition 별 access 및 pruning(해당파티션은 읽지 않도록 처내는것) 여부를 알 수 있다.
    		- 조건을 통해 해당 파티션들만 Select하도록 설정 할 수 있다

- Explain 명령
	- ID 컬럼 (query block)
		- Select 문의 고유 ID
		- Subquery 또는 Union이 없는 SQL일 경우 항상 "1"이다
		- Derived Table 또는 Subquery가 있을 경우 1씩 증가한다.
			즉, Select 별로 1씩 증가한다.

	- Select Type 컬럼
		- Select문의 타입
		- Subquery 또는 union 같은 복잡한 구조일 경우 여러가지 값을 갖는다
		- 나타날 수 있는 주요 값들
			- SIMPLE, PRIMARY, UNION, dependent union, union, result, SUBQUERY, dependent subquery, DERIVED, 
				uncachable subquery, uncachable union

	- Select Type 컬럼 값의 종류
		- Primary
			- SubQuery 또는 union을 사용한 경우 가장 바깥쪽 select문을 나타낸다
		- Subquery
			- Select되는 컬럼에 사용된 쿼리 (Nested Query)
			- Where절에 있는 select 쿼리 (Sub Query)

		- Derived
			- From절에 있는 select문 (inline view 또는 sub select)
			- MySQQL은 derived table의 결과를 temporary table에 저장한 후 outer select문이 참조한다
			- 성능상 문제가 발생할 수 있으므로 가능하면 join 형태로 변경 할 것을 권장한다

		- Union
			- Union이 사용된 query의 두번째 select문
			- 첫 번째 select문은 outer query로 실행된다

		- Table 컬럼
			- 액세스 하려는 테이블의 이름 또는 Alias
			- 조인 순서를 알 수 있다.
			- Subquery나 Union을 사용할 경우 테이블 이름 외에 다른 정보를 보여준다.
				- DerivedN : From절에 subquery가 있을 경우 표시된다 N은 해당하는 subquery의 ID이다
				- UnionN, M : union을 사용할 경우 union 작업에 참여 해야 할 id들을 보여준다.

	- Select_Type과 Table 예제
		- Join 순서 : actor -> film_actor -> film

	- Type 컬럼
		- 테이블간의 Join 타입을 나타낸다. 
		- Access 타입이라는 표현이 더 정확하다.
			- Index 스캔, 테이블 스캔 등
        - 테이블에서 row를 찾는 방법을 나타낸다.

	- Type 컬럼 값의 종류
		- ALL
			- Table 전체 스캔을 의미하며 가장 마지막에 선택되는 가장 비효율적인 방법
				- 참고 : InnoDB는 대용량 처리를 위해서 필요할 것 같은 페이지를 미리 읽어 들이는 기능이 있다 (Read Ahead 기능)

        - index (index full scan)
        	- All과 같은 join 타입이지만, index만 스캔한다
        	- Sorting 작업은 일어나지 않지만, Index 전체를 스캔 할 경우 비용이 클 수 있다.
        	- Select 되는 컬럼이 모두 Index 구성 컬럼일 경우 발생한다.

		- range (index range scan)
		- ref (index range scan)
			- 테이블 Join 시 이전 테이블의 값을 참조하기 때문에 ref라 한다
			- 하나의 값에 대해 여러개의 row를 리턴 하는 경우
			- Non unique Index 일 경우

		- eq_ref (index unique scan)
			- Join 할 때 이전 테이블의 값을 Primary key나 Unique Index가 참조할 경우
			- 단 하나의 row만 리턴하는 경우로 Index 컬럼에 '=' 연산자를 사용했을 경우
			- system과 const를 제외 했을 때 가장 좋은 Join 타입

		- const (index unique scan)
			- 단 하나의 row만 리턴한다
			- Primary Key 또는 Unique Index를 구성하는 모든 컬럼에 상수 값을 비교했을 경우
			- Optimizer에 의해 실행계획 단계에서 상수 값으로 변경해버린 다음 실행계획을 결정한다.

	- 주요 Type 값 정리
		- file

	- Type 값에 따른 성능
		- From Best To Worst
			- system -> const -> eq_ref -> ref
				-> fulltext -> ref_or_null -> index_merge
				-> unique_subquery -> index_subquery
				-> range -> index -> ALL

	- Key 컬럼
		- 실제로 Access하기 위해 사용하기로 결정한 Index
		- Key는 optimizer가 가장 적은 비용으로 query를 실행하기 위해 선택한 Index다 (minimize query cost)
		- 실행계획상 Possible_keys 컬럼에 나타난 Index 중 하나를 선택한다.
			- Use index, Force index, Ignore index로 제어
			- 반드시 가장 효율적인 Index를 선택하진 않는다

	- ref
		- Row 검색을 위해 이전 테이블에서 가져온 컬럼 값이나 상수 값(const)
		- Key 컬럼에 있는 Index가 참조하는 값이다.

	- Extra 값의 종류
		- Using index
			- 테이블을 읽지 않고 Index만 Access한다
			- Row 전체를 Access 하는 것 보다 훨씬 효율적이다
			- 조회하는 컬럼들이 전부 Index에 포함되어 있는 경우
				("covering index")

        - Using where
        	- 테이블에서 row를 추출할 다음 조건 절에 의해 filterring  한다

		- Using temporary
			- Query 수행 중 중간 결과를 저장하기 위해서 temporary table을 생성한다
			- 일반적으로 group by, order by 같은 정렬 작업이 있을 경우 발생한다

        - Using filesort
        	- Index 순서대로 정렬되지 않는 결과에 대해 external sort 작업을 할 경우 발생
        	- 정렬 작업은 메모리 또는 디스크에서 일어나지만 explain 상에서는 어떤 것을 사용하는지 알 수 없다

### MySQL Tuning Study
- Hint 사용하기
	- Use Index / Force Index / Ignore Index
		- Optimizer가 최적의 Index를 찾지 못할 때 사용
    - SQL_CACHE / SQL_NO_CACHE
    	- 쿼리의 결과를 재사용하기 위해 Cache에 저장해 둔다

- 정렬작업 최적화
	- 실행계획상 Extra 컬럼에 "Using filesort" 표시 여부로 정렬작업 여부를 알 수 있다
		- Single pass : select 컬럼을 전부 담아서 한번에 정렬한다.
		- Two pass : 정렬대상 컬럼과 PK 값만 정렬 후 Table Access를 통해 나머지 컬럼을 가져온다.

    - Sort Buffer
    	-	정렬이 필요할 경우에만 세션 별로 soft_buffer_size에 설정한 값까지 가변적으로 할당된다.
    	-	Sort buffer의 크기가 작을 경우 대상 레코드를 여러 조각으로 나누어 처리하며, 이 때는 디스크를 임시 저장소로 사용한다

	- Index를 사용한 정렬
		- Driving 테이블의 Index 구성 컬럼에 의해 정렬할 때
		- 결합 Index의 경우 구성 컬럼 순으로 정렬할 때

	- Driving 테이블만 정렬
		- Index에 의해 테이블에 접근하지, Index 구성 컬럼으로 정렬하지 않을 때

	- Join된 결과 전체를 정렬
		- Inner Table의 컬럼에 의해 정렬할 때
		- Join되는 컬럼이 Index 여부와 상관 없다

	- Delayed(지연된?) Join
		- Join이 실행되기 전에 Group by나 Order by를 먼저 처리하는 방식
			- Index를 효율적으로 사용하지 못했을 경우에 적합
			- 테이블간의 관계가 1:1 또는 M:1일 경우 (M이 클수록 유리)
			- Limit절을 같이 사용하면 더욱 효율적이다

	- Limit의 최적화
		- MySQL에서 Limit과 Offset절은 Order by 절과 결합해서 Paging 구현 시 많이 사용한다.
			- Order by 절은 Index의 구성을 적절하게 하면 불필요 Sorting 작업을 피할 수 있다.
        - Offset 값이 큰 경우 성능상의 문제점이 발생한다.
        	- Offset 값은 되도록 작게 한다.
        	- Offset, Limit 값은 테이블 스캔보다 Index 상에서 그 값을 구하고 처리하는 것이 유리하다
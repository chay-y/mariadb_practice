-- 부산광역시에 사는 고객의
--고객번호, 담당자명, 마일리지, 도시를 출력
SELECT 고객번호, 담당자명, 마일리지, 도시
FROM 고객
WHERE 도시='부산광역시';

-- 마일리지가1000보다 작은 고객에 대해
-- 고객번호, 담당자명, 마일리지, 도시를 출력
SELECT 고객번호, 담당자명, 마일리지, 도시
FROM 고객
WHERE 마일리지<1000;

-- '부산광격시에'살거나 마일리지가 1000점보다 작은 고객의
-- 고객번호,담당자명, 마일리지, 도시를 출력
SELECT 고객번호, 담당자명, 마일리지, 도시
FROM 고객
WHERE 도시='부산광역시'OR 마일리지<1000;

SELECT 고객번호, 담당자명, 마일리지, 도시
FROM 고객`고객번호``고객번호`
WHERE 도시='부산광역시'
UNION ALL
SELECT 고객번호, 담당자명, 마일리지, 도시
FROM 고객
WHERE 마일리지<1000
ORDER BY 고객번호;

-- 지역에 값이 들어있지 않은 고객의 정보를 출력
SELECT *
FROM 고객
WHERE 지역IS NULL;

UPDATE 고객
SET 지역 = NULL
WHERE 지역 = "";

--담당자 직위가 '영업과장'이거나'마케팅과장'인 고객으ㅏㅣ
--고객번호, 담당자명, 담당자직위를 출력
SELECT 고객번호, 담당자명, 담당자직위
FROM 고객
WHERE 담당자직위IN('영업 과장','마케팅과장');

--마일리지가 100000이상 200000이하인 고객에 대해
--담당자명, 마일리지 출력
SELECT 담당자명, 마일리지
FROM 고객
WHERE 마일리지 BETWEEN 100000 AND 200000;

--담당자가 김씨인 사람의 정보 출력
SELECT *
FROM 고객
WHERE 담당자명 LIKE '%정%';

-- 담당자 직위가'영업'을 포함하면서도 도시가'서울특별시'인 고객의
-- 자료의 모든 결과 출력
SELECT *
FROM 고객
WHERE 담당자직위LIKE '%영업%' AND 도시='서울특별시';

-- 도시가 '광역시'이면서
-- 고객번호 두번째 글자 또는 세번째 글자가'C' 인 고객의
-- 모든 정보 출력

SELECT *
FROM 고객
WHERE 도시 LIKE '%광역시' AND 
		(고객번호LIKE '_C%'OR고객번호 LIKE '__C%');
		
-- 1. 전화번호 뒷자리가 45로 끝나는 고객 정보
SELECT *
FROM 고객
WHERE 전화전호 LIKE '%45';

-- 2. 전화번호 중 뒤에서 네번째 부터가 45인 고객정보
SELECT *
FROM 고객
WHERE 전화번호 LIKE'%45__';

-- 3. 전화번호 중에 45가 들어간 고객정보
SELECT *
FROM 고객
WHERE 전화번호 LIKE '%45%';

-- 4. 서울에 사는 고객 중
-- 마일리지가 15000점 이상 20000점 이하인 고객의 몬든 정보
SELECT *
FROM 고객
WHERE 도시 LIKE'서울%' AND 마일리지>=15000 AND 마일리지 <=20000;

-- 6. 춘천시나 과천시 또는 광명시에 사는 고객 중에서
-- 담당자 직위에 이사 또는 사원이 들어가는 고객의
-- 모든 정보를 출력
SELECT *
FROM 고객
WHERE 도시 LIKE '춘천시' OR 도시 LIKE '광명시'
		(담당자 직위 LIKE 이사 OR 담당자 직위 LIKE 사원);

-- 7. 광역시나 특별시에 살지 않는 고객들 중에서
-- 마일리지가 많은 상위 고객 3명의 모든 정보 출력
SELECT *
FROM 고객
WHERE NOT(도시LIKE'%광역시'OR도시LIKE '%특별시'
ORDER BY 마일리지DESC
LIMIT 3; 


-- 8. 지역에 값이 들어있는 고객 중에서
-- 담당자 직위가 대표이사인 고객을 빼고 보이시오.
SELECT *
FROM 고객
WHERE 지역 IS NOT NULL AND 담당자 직위 <>'대표 이사';

-- 9. 그린무역에서 취급하는 제품 중에서 주스 제품에 대한 모든 정보를 검색
SELECT *
FROM 제품
WHERE 제품명 LIKE '%쥬스';


-- 10. 단가가 5000원 이상 10000원 이하인 주스 제품에는
-- 무엇이 있는지 검색

-- 11. 제품번호가 1,2,4,7,11,20인 제품의 모든 정보출력

-- 12. 재고 금액이 높은 상위 10개 제품에 대해
-- 제품번호, 제품명, 단가, 재고, 재고금액을 출력
SELECT *
FROM 제품
ORDER BY 단가*재고 DESC
LIMIT 10;
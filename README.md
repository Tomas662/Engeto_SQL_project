# Engeto_SQL_project
Engeto_SQL_project

„Primary“

Vytvořil jsem si tabulku t_tomas_marek_project_sql_primary_final, kde jsem 
spojil tabulku czechia_payroll s tabulkou czechia_price propojenou rokem. 
Z výše uvedené tabulky jsem poté vycházel na zodpovězení výzkumných otázek.

Jinak pro ukázku, případně vymazání tabulky, jsem používal kód (viz. níže)

SELECT * FROM t_tomas_marek_project_sql_primary_final hlavni_cr;

DROP TABLE t_tomas_marek_project_sql_primary_final;

Výzkumná otázka 1/

Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

Z tabulky t_tomas_marek_project_sql_primary_final jsem si vytáhl potřebné 
informace pro mzdy zaměstnanců. Aby se jednalo o zaměstnance, fyzickou osobu
a hodnoty byly uvedené v Kč. Industry_branch_code by neměl být nulový, aby
mi nezkresloval údaje. Tabulku jsem napojil na czechia_payroll_industry_branch
aby jsem získal název odvětví. Nakonec jsem si vypsal nejdůležitější údaje a 
spočítal percentuální meziroční nárůst pomocí napojení tabulky samu na sebe.
Výsledkem je tabulka, která zahrnuje průměrné mzdy za roky po sobě jdoucí
v určitém odvětví a percentuální meziroční nárůst mezi jednotlivými roky.

Výsledky bych shrnul asi tak, že většinou mzdy v průběhu let rostly, nicméně 
jsou i roky, kde klesaly. Například rok 2009 v peněžnictví a pojišťovnictví 
klesly mzdy oproti minulému roku o více než 9%. Dále mě zaujalo, že v těžbě 
a dobývání od roku 2009 do roku 2016 je několik let, kde mzdy reálně klesali, 
i když ne výrazně. 

Výzkumná otázka 2/

Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné 
období v dostupných datech cen a mezd?

Nejdříve jsem spočítal průměr mezd za určité období a posléze si spočítal 
i průměrné ceny potravin v též samém období. Nakonec jsem si vypsal potřebné
sloupečky a zároveň vypočítal kolik si mohl každý člověk dovolit koupit měsíčně. 

Výsledek
V 1. čtvrtletí 2006 by se ze mzdy dalo koupit 1300 chlebů/ vs. 1347 l mléka
Ve 4. čtvrtletí 2018 by se ze mzdy dalo koupit 1418 chlebů/ vs. 1738 l mléka
To mi říká, že v roce 2018 si mohu ze mzdy koupit více než v roce 2006, to znamená, 
že  v průběhu let se zvedla životní úroveň občanů (vztaženo ale pouze na ceny chleba a mléka)

Výzkumná otázka 3/

Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

Z t_tomas_marek_project_sql_primary_final jsem si vytáhl údaje potřebné 
k zjištění průměrné ceny potravin na jednotlivé roky (původně bylo po 
kvartálech). Tabulku jsem připojil na tabulku czechia_price_category,
abych získal název potraviny a např. „1 kg“. Dále jsem tabulku napojil
samu na sebe, abych zjistil percentuální meziroční nárost cen konkrétních 
potravin v určitých letech. To vše jsem si uložil do pohledu v_yearly_growth_of_food.
Z výše uvedené tabulky jsem si vypsal důležité informace pro indetifikaci potraviny 
a vypočítal průměrné roční zdražení/ zlevnění od roku 2006 až 2018.

Výsledkem je, že nejmenší průměrná meziroční roční hodnota (v průběhu let 2006 až 2018) byla záporná,
tedy -1,92%. Jedná se o potravinu cukr krystalový 1kg. Ve zkratce by se dalo říci, že cukr systematicky
klesal každý rok o 1,92% po dobu 10 let.

Výzkumná otázka 4/

Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd 
(větší než 10 %)?

Nejdříve jsem si spočítal průměrnou cenu potravin i mezd. Tabulky jsem napojil samu na 
sebe, abych zjistil meziroční porovnání mezd a potravin. 

Výsledek: Nejvyšší meziroční nárůst cen potravin byl v roce 2017
a to o 9,98%. V též samém roce stouply významně i mzdy, ale přesto to bylo
jen 6,43% (méně než vzrostla cena potravin). Meziroční nárůst cen potravin 
vyšší než 10% není. 

Výzkumná otázka 5/

Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji 
v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce 
výraznějším růstem?

Nejprve jsem si vytvořil tabulku pro mzdy, cen potravin a výšku HDP, které jsem posléze 
napojil samy na sebe, abych mohl zjistit meziroční nárůst. A zároveň vše sjednotil na
stejné roky, abych mohl hodnoty porovnat. 

Výsledek bych shrnul tak, že úplně nevím, jak bych na otázku odpověděl, protože z mé tabulky 
mi přijde, že vyšší HDP nemá nějakou vyšší souvislost se mzdami, případně cenami potravin.

„Secondary“
Vybral jsem si „Europe“ ve sloupci „continent“ na roky 2006 až 2018 (jako roky, které jsme 
filtrovali v primárním úkolu). Populace má pro jeden stát na různé roky stejné hodnoty, což 
není správně (nesprávné hodnoty). Sloupec „GDP“ vypadá v pořádku, nicméně ve sloupci „gini“ 
jsou „NULL hodnoty“. Nemůžeme je vyfiltrovat pomocí WHERE, protože kdybychom to udělali, tak 
přijdeme o celý řádek a přišli bychom o hodnoty ve sloupci „GDP“.   

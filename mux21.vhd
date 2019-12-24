LIBRARY IEEE;                         --库引用声明
USE IEEE.STD_LOGIC_1164.ALL;          --包引用声明

ENTITY mux21 IS                       --实体
  PORT (
    d0, d1 : IN STD_LOGIC;              --实体内端口描述
    s : IN STD_LOGIC;                     --输入端口
    q : OUT STD_LOGIC);                   --输出端口
END mux21;
ARCHITECTURE arc_express OF mux21 IS  --结构体
  SIGNAL a1, a2 : STD_LOGIC;            --内部信号、类型、常量声明
BEGIN
  q <= a1 OR a2;                        --功能语句
  a1 <= d0 AND (NOT s);
  a2 <= d1 AND s;
END arc_express;
CONFIGURATION con OF mux21 IS         --配置体
  FOR arc_express                       --描述各种层与层的连接关系以及
  END FOR;                              --实体与结构体之间的关系
END con;                                --唯一结构体时，配置体可省略
ARCHITECTURE arc_if OF mux21 IS
BEGIN
  PROCESS (d0, d1, s)
  BEGIN
    IF s = '0' THEN
      q <= d0;
    ELSE
      q <= d1;
    END IF;                           --综合结果：二选一选择器
  END PROCESS;
END arc_if;
ARCHITECTURE arc_when OF mux21 IS
BEGIN
  q <= d0 WHEN s = '0' ELSE
    d1;
END arc_when;
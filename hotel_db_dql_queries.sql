-- ============================================================
-- HOTEL MANAGEMENT SYSTEM - ANALYTICAL REPORTING QUERIES (DQL)
-- ============================================================

-- 1. Total Revenue Breakdown (Room Charges vs. Service Revenue)
SELECT 
    ISNULL(SUM(DATEDIFF(DAY, B.CIDATE, B.CODATE) * R.Rate), 0) AS Total_Room_Revenue,
    ISNULL(SUM(S.TAMNT), 0) AS Total_Service_Revenue,
    (ISNULL(SUM(DATEDIFF(DAY, B.CIDATE, B.CODATE) * R.Rate), 0) + ISNULL(SUM(S.TAMNT), 0)) AS Total_Gross_Revenue
FROM Bookings B
JOIN Rooms Rm ON B.RID = Rm.RID
JOIN RType R ON Rm.RTID = R.RTID
LEFT JOIN SUSAGE S ON B.BID = S.BID
WHERE B.BSTATUS IN ('CheckedOut', 'CheckedIn');

-- 2. Hotel Occupancy Rate Percentage
SELECT 
    COUNT(*) AS Total_Rooms,
    SUM(CASE WHEN Status = 'Occupied' THEN 1 ELSE 0 END) AS Occupied_Rooms,
    SUM(CASE WHEN Status = 'Available' THEN 1 ELSE 0 END) AS Available_Rooms,
    SUM(CASE WHEN Status = 'Maintenance' THEN 1 ELSE 0 END) AS Maintenance_Rooms,
    ROUND((CAST(SUM(CASE WHEN Status = 'Occupied' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*)) * 100, 2) AS Occupancy_Rate_Percentage
FROM Rooms;

-- 3. Top 5 Highest-Spending Guests
SELECT TOP 5 
    G.GID,
    G.FName + ' ' + G.LName AS Guest_Name,
    G.Phone,
    COUNT(DISTINCT B.BID) AS Total_Bookings,
    SUM(P.PAMOUNT) AS Total_Spent
FROM Guests G
JOIN Bookings B ON G.GID = B.GID
JOIN PAYMENT P ON B.BID = P.BID
WHERE P.PSTATUS = 'Paid'
GROUP BY G.GID, G.FName, G.LName, G.Phone
ORDER BY Total_Spent DESC;

-- 4. Monthly Staff Payroll Summary by Role & Shift
SELECT 
    Role,
    Shift,
    COUNT(ID) AS Total_Staff_Count,
    SUM(Salary) AS Total_Monthly_Payroll,
    ROUND(AVG(Salary), 2) AS Average_Salary
FROM Staff
GROUP BY Role, Shift
ORDER BY Role, Shift;

-- 5. Service Usage Performance & Revenue
SELECT 
    S.SID,
    S.Sname AS Service_Name,
    S.SCOST AS Unit_Cost,
    ISNULL(SUM(U.QUANTITY), 0) AS Times_Requested,
    ISNULL(SUM(U.TAMNT), 0) AS Total_Revenue_Generated
FROM Services S
LEFT JOIN SUSAGE U ON S.SID = U.SID
GROUP BY S.SID, S.Sname, S.SCOST
ORDER BY Total_Revenue_Generated DESC;

-- 6. Online vs. Offline Booking Performance
SELECT 
    BTHROUGH AS Booking_Channel,
    COUNT(BID) AS Total_Bookings,
    SUM(CASE WHEN BSTATUS = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled_Bookings,
    ROUND((CAST(SUM(CASE WHEN BSTATUS = 'Cancelled' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(BID)) * 100, 2) AS Cancellation_Rate_Pct
FROM Bookings
GROUP BY BTHROUGH;
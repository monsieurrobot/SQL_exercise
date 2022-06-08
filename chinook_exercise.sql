/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. 
 Each track is stored using one of the digital formats and has a genre. 
 The store has also some playlists, where a single track can be part of several playlists. 
 Orders are recorded for customers, but are called invoices. 
 Every customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE

SELECT * FROM playlists;



--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/

SELECT artists.name, albums.AlbumId FROM artists
LEFT JOIN albums ON artists.ArtistId = albums.ArtistId
WHERE albumId IS NULL;


/* TASK II
Which artists recorded any tracks of the Latin genre?
*/
SELECT artists.name FROM artists
JOIN albums ON artists.ArtistId = albums.ArtistId
JOIN tracks ON albums.AlbumId = tracks.AlbumId
WHERE tracks.GenreId = 7;

/* TASK III
Which video track has the longest length?
*/
SELECT Name, MAX(Milliseconds) FROM tracks
WHERE MediaTypeId = 3;

/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/

SELECT FirstName, LastName FROM customers 
WHERE City = 'Edmonton';

/* TASK V
Find the managers of employees supporting Brazilian customers.
*/

SELECT boss.* from customers
    join employees on employees.EmployeeId=customers.SupportRepId
    join employees as boss on employees.ReportsTo=boss.EmployeeId
    where customers.Country='Brazil'
    GROUP by boss.EmployeeId;

/* TASK VI
Which playlists have no Latin tracks?
*/

SELECT playlists.name FROM playlists
JOIN playlist_track ON playlists.PlaylistId = playlist_track.PlaylistId
JOIN tracks ON playlist_track.TrackId = tracks.TrackId
WHERE tracks.GenreId != 7;

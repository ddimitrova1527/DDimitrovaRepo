-- Брой на потребители
select count(*) from users
-- Най-стария потребител
select birthdate, username
from users
order by birthdate asc limit 1
-- Най-младия потребител
select birthdate, username
from users
order by birthdate desc limit 1
-- колко юзъра са регистрирани с мейли от abv.bg и колко от gmail.com и колко с различни от двата
select count(*) from users
where email like '%gmail.com'
union all
select count(*) from users
where email like '%abv.bg' union all select count(*) from users
where email not like '%abv.bg' and email not like '%gmail.com'
-- кои юзъри са banned
select username from users
where isbanned=1
-- изкарайте всички потребители от базата като ги наредите по име в азбучен ред и дата на раждане(от най-младия към най-възрастния)
select * from users
order by username, birthdate desc
-- изкарайте всички потребители от базата, на които потребителското име започва с a
select * from users
where username like 'a%'
-- изкарайте всички потребители от базата, които съдържат а username името си
select * from users
where username like '%a%'
-- изкарайте всички потребители от базата, чието име се състои от 2 имена
select * from users
where username like '% %'
или
select * from users
where username REGEXP '[[a-z][[:blank:]][a-z]'
-- Регистрирайте 1 юзър през UI-а и го забранете след това от базата
update users
set isBanned=0
where username='Testuser1'
-- Брой на всички постове
select count(*) from posts
-- Брой на всички постове групирани по статуса на post-a
select postStatus, count(*) from posts
group by postStatus
-- Намерете поста/овете с най-къс caption
select min(caption) from posts
-- Покажете поста с най-дълъг caption
select max(caption) from posts
-- Кой потребител има най-много постове. Използвайте join заявка
select u.username, count(*) as posts
from users u
left join posts p
on u.id=p.userId
group by u.username
order by posts desc limit 1
-- Кои потребители имат най-малко постове. Използвайте join заявка
select u.username, count(*) as posts
from users u
left join posts p
on u.id=p.userId
group by u.username
order by posts limit 1
-- Колко потребителя с по 1 пост имаме. Използвайте join заявка, having clause и вложени заявки
select count(username)
from
(
select u.username, count(*) as posts
from users u
left join posts p
on u.id=p.userId
group by u.username
having (posts = 1)
) a
-- Колко потребителя с по малко от 5 поста имаме. Използвайте join заявка, having clause и вложени заявки
select count(username)
from
(
select u.username, count(*) as posts
from users u
left join posts p
on u.id=p.userId
group by u.username
having (posts < 5)
) a
-- Кои са постовете с най-много коментари. Използвайте вложена заявка и where clause
select *
from posts
where commentsCount = (select max(commentsCount) from posts)
-- Покажете най-стария пост. Може да използвате order или с aggregate function
select * from posts
where createdAt = (select min(createdAt) from posts)
select * from posts
order by createdAt limit 1
-- Покажете най-новия пост. Може с order или с aggregate function
select * from posts
where createdAt = (select max(createdAt) from posts)
select * from posts
order by createdAt desc limit 1
-- Покажете всички постове с празен caption
select * from posts
where caption=''
-- Създайте потребител през UI-а, добавете му public пост през базата и проверете дали се е създал през UI-а
insert into posts (caption, coverUrl, postStatus, createdAt, isDeleted, commentsCount, userId)
values ('test', 'https://i.imgur.com/gMPUKj7.jpg', 'public', curdate(), 0, 0, 2 )
-- Покажете всички постове и коментарите им ако имат такива
select p.id, caption, content
from posts p
left join comments c
on p.id = c.postId
order by p.id
-- Покажете само постове с коментари и самите коментари
select p.id, caption, content
from posts p
inner join comments c
on p.id = c.postId
order by p.id
-- Покажете името на потребителя с най-много коментари. Използвайте join клауза.
select u.username, count(*) as c
from comments c
inner join users u
on c.userId = u.id
group by u.username
order by c desc
-- Покажете всички коментари, към кой пост принадлежат и кой ги е направил. Използвайте join клауза.
select u.username, c.content, p.id, p.caption
from comments c
inner join users u
on c.userId = u.id
inner join posts p
on c.postId = p.id
-- Кои потребители са like-нали най-много постове
select u.username, count(*) c
from users_liked_posts ul
inner join users u
on u.id = ul.usersId
group by u.username
order by c desc
-- Кои потребители не са like-вали постове.
select u.username
from users u
left join
users_liked_posts ul
on u.id=ul.usersId
where ul.usersId is null
order by u.username
 -- Кои постове имат like-ове. Покажете id на поста и caption
select p.id, p.caption
from posts p
inner join users_liked_posts ul
on p.id=ul.postsId
 -- Кои постове имат най-много like-ове. Покажете id на поста и caption.
select p.id, p.caption, count(*) c
from posts p
inner join users_liked_posts ul
on p.id=ul.postsId
group by p.id, p.caption
order by c desc
-- Покажете всички потребители, които не follow-ват никого
select u.username from users u
left join
users_followers_users uf
on u.id = usersId_1
where usersId_1 is null
-- Покажете всички потребители, които не са follow-нати от никого
select u.username from users u
left join
users_followers_users uf
on u.id = usersId_2
where usersId_2 is null
-- Регистрирайте потребител през UI. Follow-нете някой съществуващ потребител и проверете дали записа го има в базата
ID на новосъздадения потребител
select id from users
where email='......'
ID на follow-натия потребител
select id from users
where username='......'
select * from users_followers_users
where usersId_1='първото ID' and usersId_2='второто ID
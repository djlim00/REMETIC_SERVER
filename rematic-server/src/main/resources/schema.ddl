CREATE TABLE `user` (
                        `user_id`	bigint	NOT NULL AUTO_INCREMENT PRIMARY KEY ,
                        `profile_image_url`	TEXT	NULL,
                        `introduction`	TEXT	NULL,
                        `nickname`	varchar(200)	NOT NULL,
                        `user_email`	varchar(200)	NOT NULL,
                        `status`	varchar(200)	NOT NULL	DEFAULT 'active',
                        `created_at` timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                        `updated_at` timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `post` (
                        `post_id`	BIGINT(20)	NOT NULL AUTO_INCREMENT PRIMARY KEY ,
                        `title`	TEXT	NOT NULL,
                        `content`	TEXT	NOT NULL,
                        `writer_nickname`	varchar(200)	NOT NULL,
                        `images`	TEXT	NULL,
                        `category`	varchar(200)	NOT NULL,
                        `hates`	INT	NOT NULL	DEFAULT 0,
                        `likes`	INT	NOT NULL	DEFAULT 0,
                        `scrap`	INT	NOT NULL	DEFAULT 0,
                        `views`	INT	NOT NULL	DEFAULT 0,
                        `realtime_views`	VARCHAR(255)	NOT NULL,
                        `anonymity`	BOOLEAN	NOT NULL,
                        `status`	varchar(200)	NULL	DEFAULT 'active',
                        `created_at` timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                        `updated_at` timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        `user_id`	bigint	NOT NULL

);

CREATE TABLE `comment` (
                           `comment_id`	bigint	NOT NULL AUTO_INCREMENT PRIMARY KEY ,
                           `likes`	bigint	NOT NULL	DEFAULT 0,
                           `hates`	bigint	NOT NULL	DEFAULT 0,
                           `created_at`	timestamp	NOT NULL	DEFAULT current_timestamp,
                           `updated_at` timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           `parent_id`	bigint	NULL,
                           `post_id`	BIGINT	NOT NULL,
                           `user_id`	bigint	NOT NULL
);

CREATE TABLE `recent_keyword` (
                                  `recent_keyword_id`	bigint	NOT NULL AUTO_INCREMENT PRIMARY KEY ,
                                  `keyword`	text	NOT NULL,
                                  `created_at`	timestamp	NOT NULL DEFAULT current_timestamp,
                                  `status`	varchar(200)	NOT NULL DEFAULT 'active',
                                  `user_id`	bigint	NOT NULL
);

ALTER TABLE post ADD foreign key(user_id) references user(user_id);
ALTER TABLE comment ADD foreign key(post_id) references post(post_id);
ALTER TABLE comment ADD foreign key (user_id) references user(user_id);
ALTER TABLE comment ADD foreign key (parent_id) references comment(comment_id);
ALTER TABLE recent_keyword ADD foreign key(user_id) references user(user_id);

-- CREATE TABLE `User` (
--     `user_id` bigint AUTO_INCREMENT PRIMARY KEY,
--     `user_email` varchar(200) NOT NULL,
--     `profile_image_url` text NULL,
--     `introduction` text NULL,
--     `nickname` varchar(200) NOT NULL,
--     `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--     `status` varchar(255) NOT NULL DEFAULT 'active'
-- );
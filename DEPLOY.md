# v2.0

alter table produto add column ideal_profile varchar(8000);
alter table produto add column initial_price bigint(20);
alter table produto add column price_kind bigint(20);
alter table produto add column trial_kind bigint(20);
alter table produto add column trial_other_text varchar(255);
alter table produto add column access_web_navigation tinyint(1);
alter table produto add column access_mobile_ios tinyint(1);
alter table produto add column access_mobile_android varchar(255);
alter table produto add column access_desktop_pc tinyint(1);
alter table produto add column access_desktop_apple tinyint(1);
alter table produto add column access_desktop_linux tinyint(1);
alter table produto add column support_hour_kind bigint(20);
alter table produto add column support_email tinyint(1);
alter table produto add column support_chat tinyint(1);
alter table produto add column support_phone tinyint(1);
alter table produto add column training_video tinyint(1);
alter table produto add column training_text tinyint(1);
alter table produto add column training_presential tinyint(1);
alter table produto add column training_ebook tinyint(1);
alter table produto add column country_id bigint(20);
alter table produto add column start_year bigint(20);
alter table produto add avaliacaos_count bigint(20);

alter table categoria add column featured tinyint(1);
alter table categoria add column featured_position bigint(20);

CREATE TABLE `countries` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=latin1;

- `Produto.all.map { |p| Produto.reset_counters(p.id, :avaliacaos) }`
- `bundle exec rake RAILS_ENV=production db:import_countries`

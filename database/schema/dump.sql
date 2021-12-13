-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.7.33 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Volcando estructura para tabla plantas.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla plantas.categories: ~3 rows (aproximadamente)
DELETE FROM `categories`;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `name`) VALUES
   (1, 'Medicinal'),
   (2, 'Ornamental'),
   (3, 'Semilla');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Volcando estructura para tabla plantas.delivery_orders
CREATE TABLE IF NOT EXISTS `delivery_orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `shipping_agent_id` bigint(20) unsigned NOT NULL,
  `delivery_date` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `delivery_orders_order_id_foreign` (`order_id`),
  KEY `delivery_orders_shipping_agent_id_foreign` (`shipping_agent_id`),
  CONSTRAINT `delivery_orders_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `delivery_orders_shipping_agent_id_foreign` FOREIGN KEY (`shipping_agent_id`) REFERENCES `shipping_agents` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla plantas.delivery_orders: ~8 rows (aproximadamente)
DELETE FROM `delivery_orders`;
/*!40000 ALTER TABLE `delivery_orders` DISABLE KEYS */;
INSERT INTO `delivery_orders` (`id`, `order_id`, `shipping_agent_id`, `delivery_date`) VALUES
   (1, 1, 1, '2021-12-17 04:47:17'),
   (2, 2, 4, '2021-12-13 04:48:16'),
   (3, 3, 1, '2021-12-14 04:55:38'),
   (4, 4, 5, '2021-12-14 04:56:29'),
   (5, 5, 2, '2021-12-14 04:57:48'),
   (6, 6, 1, '2021-12-13 04:59:55'),
   (7, 7, 1, '2021-12-17 05:02:50'),
   (8, 8, 5, '2021-12-15 05:04:54');
/*!40000 ALTER TABLE `delivery_orders` ENABLE KEYS */;

-- Volcando estructura para tabla plantas.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla plantas.failed_jobs: ~0 rows (aproximadamente)
DELETE FROM `failed_jobs`;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Volcando estructura para tabla plantas.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla plantas.migrations: ~16 rows (aproximadamente)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
   (9, '2014_10_12_000000_create_users_table', 1),
   (10, '2014_10_12_100000_create_password_resets_table', 1),
   (11, '2019_08_19_000000_create_failed_jobs_table', 1),
   (12, '2019_12_14_000001_create_personal_access_tokens_table', 1),
   (13, '2020_12_02_005807_create_categories_table', 1),
   (14, '2021_12_01_212202_create_products_table', 1),
   (15, '2021_12_02_002950_create_orders_table', 1),
   (16, '2021_12_02_004644_create_order_products_table', 1),
   (17, '2021_12_02_023018_create_shipping_agents_table', 1),
   (18, '2021_12_02_023101_create_delivery_orders_table', 2),
   (19, '2021_12_02_024129_create_payment_methods_table', 3),
   (20, '2021_12_02_024348_create_user_payment_methods_table', 4),
   (21, '2021_12_09_034442_add_image_products_table', 5),
   (22, '2021_12_09_044751_add_status_orders_table', 6),
   (23, '2021_12_09_044804_add_quantity_order_producs_table', 6),
   (24, '2021_12_09_070407_add_estimate_date_delivery_table', 6);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Volcando estructura para tabla plantas.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `total_cost` int(11) NOT NULL,
  `delivery_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `orders_user_id_foreign` (`user_id`),
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla plantas.orders: ~8 rows (aproximadamente)
DELETE FROM `orders`;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`id`, `total_cost`, `delivery_at`, `user_id`, `created_at`, `updated_at`, `status`) VALUES
   (1, 0, NULL, 3, '2021-12-10 04:47:17', '2021-12-10 04:48:07', 1),
   (2, 27250, NULL, 3, '2021-12-10 04:48:16', '2021-12-10 04:48:55', 1),
   (3, 9000, NULL, 3, '2021-12-10 04:55:38', '2021-12-10 04:56:11', 1),
   (4, 7000, NULL, 3, '2021-12-10 04:56:29', '2021-12-10 04:57:35', 1),
   (5, 7000, NULL, 3, '2021-12-10 04:57:48', '2021-12-10 04:58:03', 1),
   (6, -21000, NULL, 3, '2021-12-10 04:59:55', '2021-12-10 05:02:30', 1),
   (7, -14000, NULL, 3, '2021-12-10 05:02:50', '2021-12-10 05:04:47', 1),
   (8, 39000, NULL, 3, '2021-12-10 05:04:54', '2021-12-10 05:05:08', 0);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- Volcando estructura para tabla plantas.order_products
CREATE TABLE IF NOT EXISTS `order_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `order_products_order_id_foreign` (`order_id`),
  KEY `order_products_product_id_foreign` (`product_id`),
  CONSTRAINT `order_products_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla plantas.order_products: ~5 rows (aproximadamente)
DELETE FROM `order_products`;
/*!40000 ALTER TABLE `order_products` DISABLE KEYS */;
INSERT INTO `order_products` (`id`, `order_id`, `product_id`, `quantity`) VALUES
   (3, 2, 1, 1),
   (4, 2, 2, 1),
   (5, 2, 3, 2),
   (12, 8, 1, 3),
   (13, 8, 2, 2);
/*!40000 ALTER TABLE `order_products` ENABLE KEYS */;

-- Volcando estructura para tabla plantas.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `available_quantity` int(10) unsigned NOT NULL,
  `price` int(10) unsigned NOT NULL DEFAULT '0',
  `instruccions` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_category_id_foreign` (`category_id`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla plantas.products: ~29 rows (aproximadamente)
DELETE FROM `products`;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `name`, `description`, `available_quantity`, `price`, `instruccions`, `category_id`, `created_at`, `updated_at`, `image_url`) VALUES
   (1, 'Aloe Vera', 'De la familia de las Asphodelaceae, pertenece al género Aloe, que cuenta con más de 350 especies vegetales. Esta especie, muy habitual entre las plantas de interior.', 31, 7000, 'sin instrucciones', 1, NULL, '2021-12-10 05:05:08', 'https://www.almanac.com/sites/default/files/styles/max_1300x1300/public/image_nodes/aloe-vera-white-pot_sunwand24-ss_edit.jpg?itok=CfEl7W7n'),
   (2, 'Valeriana', 'La valeriana o Valeriana officinalis es una de las plantas medicinales más empleadas en la fitoterapia. Y es normal, ya que tiene infinidad de beneficios pero quizás el más conocido sea el ayudar a relajarnos.', 12, 9000, 'sin instrucciones', 1, NULL, '2021-12-10 05:05:06', 'https://www.flores.ninja/wp-content/uploads/2016/12/Valeriana.jpg'),
   (3, 'Alcachofa', 'La alcachofa o Cynara scolymus es una planta muy habitual en nuestras recetas del día a día. Pues bien, esta planta tiene multitud de beneficios. Destaca su gran aporte de calcio y fósforo, así como otros minerales como hierro, potasio, magnesio y zinc.', 7, 3750, 'sin instrucciones', 1, NULL, '2021-12-10 04:48:42', 'https://www.hogarmania.com/archivos/202012/alcachofa-planta-desintoxicante-protectora-hepatica-1280x720x80xX.jpg'),
   (4, 'Amapola', 'La amapola o Papaver rhoeas L., es una planta curativa de la que se usan las semillas. Con estas semillas se consigue prevenir enfermedades cardiovasculares, anemias o afecciones de la piel.', 27, 4900, 'Su consumo es bien simple: solo tienes que añadirlas por ejemplo a las meriendas en un yogur o batido.', 1, NULL, NULL, 'https://www.guiasdecompra.com/wp-content/uploads/2019/09/plana-de-amapola.jpg'),
   (5, 'Eucalipto', 'El eucalipto o eucaliptas es una de las plantas que más usamos para decorar la casa.Pero además de decorar el interior de nuestra casa, los eucaliptos son plantas medicinales muy beneficiosas para la salud.', 34, 16000, 'sin instrucciones', 1, NULL, NULL, 'https://thumbs.dreamstime.com/b/peque%C3%B1a-planta-de-eucalipto-en-maceta-la-tabla-blanca-frente-pared-gris-213231205.jpg'),
   (6, 'Lavanda', 'La lavanda es un género de plantas de la familia de las lamiáceas. Mejora la calidad del sueño y ayuda a relajarnos en situaciones de estrés. ', 59, 5500, 'sin instrucciones', 1, NULL, NULL, 'https://m.media-amazon.com/images/I/41D0dxasBiL._SL500_.jpg '),
   (7, 'Tomillo', 'El tomillo o también conocido como Thymus, además de ser uno de los condimentos más usados en la cocina también se utiliza como remedio para aliviar los dolores de garganta y afonías.', 80, 3250, 'sin instrucciones', 1, NULL, NULL, 'https://www.mundohuerto.com/images/slides-huerto/min/planta-tomillo-maceta.jpg'),
   (9, 'Espliego', 'Tanto en infusión como oliendo su perfume (es una planta medicinal muy aromática), el espliego consigue aplacar el estrés tanto físico como emocional.', 31, 1550, 'sin instrucciones', 1, NULL, NULL, 'https://media.centrodejardineriacardedeu.com/product/lavanda-espliego-lavandula-officinalis-800x800.jpeg'),
   (10, 'Diente de León', 'El diente de león o Taraxacum officinale, se utiliza desde hace siglos como remedio natural para prevenir los trastornos digestivos. Además de esto, esta planta tiene gran cantidad de vitaminas del grupo B.', 63, 6900, 'sin instrucciones', 1, NULL, NULL, 'https://www.jardineriaon.com/wp-content/uploads/2015/02/Taraxacum_officinale_flores-830x622.jpg'),
   (11, 'Estevia', 'Contiene minerales, fitonutrientes, vitaminas, oligoelementos y aceites volátiles que proporcionan a esta planta una serie de propiedades nutricionales y medicinales.', 43, 6000, 'sin instrucciones', 1, NULL, NULL, 'http://www.remedioscaseros.net/wp-content/uploads/files/article/s/stevia-como-cultivarla-en-maceta_0452w.jpg'),
   (12, 'Escaramujo', 'El escaramujo o también conocida como rosa canina es una de las plantas medicinales que se usa para aliviar el dolor relacionado con la artritis y ciertas infecciones', 0, 3000, 'sin instrucciones', 1, NULL, NULL, 'https://www.elmueble.com/medio/2021/02/07/plantas-medicinales-escaramujo_cdaca92f_493x640.jpg'),
   (13, 'Oregano', 'El orégano o también conocido como Origanum vulgare, es una de las plantas más usadas en la cocina. Sin embargo, también tienen multitud de propiedades medicinales, entre las que destaca su acción antioxidante.', 55, 995, 'sin instrucciones', 1, NULL, NULL, 'https://estaticos.miarevista.es/uploads/images/gallery/5773a8d5bcc59cd204bcf313/oregano1.jpg'),
   (14, 'Albahaca', 'La albahaca o Ocimum basilicum es una planta medicinal que también utilizamos (y nos encanta) para hacer nuestras mejores recetas. Combate el dolor y el malestar general. También alivia el malestar estomacal.', 40, 1350, 'sin instrucciones', 1, NULL, NULL, 'https://cr.epaenlinea.com/pub/media/version20200605/catalog/product/cache/a83b746ef25730b9cb1cc414bac0f04a/0/8/0804364_17.jpg'),
   (15, 'Manzanilla', 'La manzanilla o Chamaemelum nobile es una de las plantas medicinales y curativas más conocidas por ayudar a aliviar los trastornos digestivos. Además, tiene efectos antiinflamatorios, antibacterianos y relajantes.', 33, 6400, 'sin instrucciones', 1, NULL, NULL, 'https://t2.ev.ltmcdn.com/es/posts/3/0/2/para_que_sirve_la_planta_de_manzanilla_beneficios_y_usos_2203_1_600.jpg'),
   (16, 'Alcatraz', 'Requiere de mucha luz para florecer, pero se recomienda que esta sea indirecta. Se adapta bien a climas cálidos y fríos, por igual, aunque debemos procurar que no sea extremos, ya que no tolera bien las heladas ni el calor exagerado.', 12, 4520, 'Durante su floración el riego debe ser abundante, aunque puede reducirse durante el otoño y el invierno. ', 2, NULL, NULL, 'https://cdn2.melodijolola.com/media/files/styles/nota_imagen/public/field/image/pxfuel.com_6.jpg'),
   (17, 'Petunia', 'Florece profusamente y existe una amplia variedad de petunias de distintos colores, incluido el negro.', 3, 2200, 'Recomendable mucho el sol directo y requiere de riegos frecuentes. En verano, de preferencia, los riegos deben ser diarios. ', 2, NULL, NULL, 'http://1.bp.blogspot.com/-dry2BKSb1sI/TfCdSsYk8HI/AAAAAAAAAYA/PRs6S2-BOh8/s1600/petunias%2B1.jpg'),
   (18, 'Coleos', 'Son plantas perennes propias de Asia y África. Crecen en zonas tropicales, por lo que requieren de mucha humedad y agua.', 15, 3500, 'Necesitan mucha luz solar y no soportan bajas temperaturas.', 2, NULL, NULL, 'https://www.hola.com/imagenes/decoracion/20210224184875/cultivar-coleo-plantas-interior-mc/0-937-298/coleo1-e.jpg'),
   (19, 'Bambú', 'El bambú, propio de China, Japón o Corea del Sur, es un árbol que también puede considerarse como ornamental. ', 25, 1500, 'Se recomienda sembrarlo durante la primavera y ser pacientes', 2, NULL, NULL, 'https://t2.uc.ltmcdn.com/images/0/3/6/cuidados_del_bambu_de_la_suerte_37630_600_square.jpg'),
   (20, 'Alamanda', 'Planta trepadora o enredadera con bonitas', 7, 2500, 'Recomendable regar dos veces por semana durante el verano.', 2, NULL, NULL, 'https://www.floresyplantas.net/wp-content/uploads/flores-de-allamanda-cathartica.jpg'),
   (21, 'Anturio', 'Las hojas son de consistencia y grosor notables, ovales, en', 16, 3500, 'Regar en verano unas 3 veces a la semana y 1 vez por semana en invierno.', 2, NULL, NULL, 'https://www.hola.com/imagenes/decoracion/20210326186727/cultivar-anturio-plantas-interior-mc/0-935-193/anturio1-m.jpg?filter=w500'),
   (22, 'Corona de reina', ' Planta trepadora, con zarcillos presentes en las terminaciones de las inflorescencias, tiene las raices tuberosas.', 0, 950, 'Se recomienda regar cada 2 o tres semanas y permitir que seque entre uno y otro riego.', 2, NULL, NULL, 'https://www.elmundoforestal.com/wp-content/uploads/2021/01/bellisima-b.jpg'),
   (23, 'Camelina', 'Arbusto trepador, perennifolio, el tronco y las ramas tienen espinas.', 1, 2500, 'En verano regar cada 3 dias y durante el invierno mas reducido su riego.', 2, NULL, NULL, 'https://i.pinimg.com/originals/7c/9c/85/7c9c856a8a3b2fc2682995cc45d34163.jpg'),
   (24, 'Trompeta de ángel', 'Arbusto de hoja perenne con flores en forma de trompeta, huelen sobre todo durante la noche.', 0, 1500, 'Se recomienda regar durante su crecimiento y la floración.', 2, NULL, NULL, 'https://universidadagricola.com/wp-content/uploads/2018/07/img_5b59259cb5506.png'),
   (25, 'Cordyline rojo', 'Arbusto de varios tallos.', 5, 850, 'Regar 2 vees por semana en verano y 1 vez por semana en invierno.', 2, NULL, NULL, 'https://ornamentalis.com/wp-content/uploads/2015/01/Cordyline-terminalis.jpg'),
   (26, 'Semillas de rabanito', 'Variedad de hojas escasas, pequeñas, de buena precocidad. La raíz es globosa.', 0, 1250, 'Sembrar directamente en terreno de asiento, a voleo y on la semilla enterrada muy superficialmente.', 3, NULL, NULL, 'https://www.eljardindeatras.com/wp-content/plugins/aawp/public/image.php?url=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvNTE0MEtyMjBSREwuanBn'),
   (27, 'Semillas de hierbabuena', 'Hierba perenne de porte robusto, muy peluda y aromática.', 29, 950, 'Sembrar el lugares húmedos y para su recolección se cortan los tallos poco antes de florecer', 3, NULL, NULL, 'https://m.media-amazon.com/images/I/81X4JqFCdCL._AC_SL1500_.jpg'),
   (28, 'Semillas de zanahoria', 'Variedad tipo chantenay de forma cónica y hombros anchos.', 8, 500, 'Sembrar en hileras a 2 cm entre semillas con una profunidad de 2 cm', 3, NULL, NULL, 'https://www.hortaflor.net/media/zanahoria-hf.jpg'),
   (29, 'Semillas de chile', 'Variedad de jalapeño de polinización abierta.', 2, 750, 'Sembrar 1 semilla por celda a 1 cm de profunidad.', 3, NULL, NULL, 'http://cdn.shopify.com/s/files/1/0257/6043/2233/products/Semillas_Chile_Jalapeno.JPG?v=1565835763'),
   (30, 'Catnip', 'La menta gatuna es una planta perenne robusta de forma redondeada que alcanza entre 2 a 3 pies de altura.', 420, 420, 'La menta gatuna se desarrolla a pleno sol en suelos húmedos con buen drenaje. También tolera la sombra parcial', 3, NULL, NULL, 'https://http2.mlstatic.com/D_NQ_NP_880663-MLC47360617246_092021-O.webp');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- Volcando estructura para tabla plantas.shipping_agents
CREATE TABLE IF NOT EXISTS `shipping_agents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla plantas.shipping_agents: ~5 rows (aproximadamente)
DELETE FROM `shipping_agents`;
/*!40000 ALTER TABLE `shipping_agents` DISABLE KEYS */;
INSERT INTO `shipping_agents` (`id`, `name`, `created_at`, `updated_at`) VALUES
   (1, 'Ericka', NULL, NULL),
   (2, 'Adrian', NULL, NULL),
   (3, 'Luis', NULL, NULL),
   (4, 'Roxi', NULL, NULL),
   (5, 'Antonio', NULL, NULL);
/*!40000 ALTER TABLE `shipping_agents` ENABLE KEYS */;

-- Volcando estructura para tabla plantas.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla plantas.users: ~4 rows (aproximadamente)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
   (1, 'Btest', 'test@gmail.com', NULL, '$2y$10$rZNcuw0mUyT56hpkJ8F.GOCDjYXN8hAzCWNeWMn.EAKi9xuRN/0fm', NULL, '2021-12-08 20:52:38', '2021-12-08 20:52:38'),
   (2, 'Btest', 'test1@gmail.com', NULL, '$2y$10$2uvyLES/h2OeRJLEbN.wA.T.92SY0KK7Fb0B8ofvwnu3h5XuI9Apq', NULL, '2021-12-08 20:53:22', '2021-12-08 20:53:22'),
   (3, 'Bryan', 'bryan@gmail.com', NULL, '$2y$10$PA/7Ff7mJcWyxCBnB3NW/ugcFvGCfyC6V6tiXguf51WeoY.42gehS', NULL, '2021-12-10 04:39:25', '2021-12-10 04:39:25'),
   (4, 'bryan', 'bryan1@gmail.com', NULL, '$2y$10$z.ScElGpVhFMKGzikvX9.exfo4sOIvrDuK7qJqPdKDgFpvAuSg2ou', NULL, '2021-12-10 04:43:16', '2021-12-10 04:43:16');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

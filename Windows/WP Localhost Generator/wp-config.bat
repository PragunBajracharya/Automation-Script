@echo off

SET databaseName=%1
SET uploads=%2
SET WP_HOME=%3
SET WP_SITEURL=%4
SET tablePrefix=%5

SET databaseName=%databaseName:"=%
SET tablePrefix=%tablePrefix:"=%
SET uploads=%uploads:"=%
SET WP_HOME=%WP_HOME:"=%
SET WP_SITEURL=%WP_SITEURL:"=%


SET line2=/^*^*
SET line3=^* The base configuration for WordPress
SET line4=^*
SET line5=^* The wp-config.php creation script uses this file during the installation.
SET line6=^* You don't have to use the web site, you can copy this file to 'wp-config.php'
SET line7=^* and fill in the values.
SET line8=^*
SET line9=^* This file contains the following configurations:
SET line10=^*
SET line11=^* ^* MySQL settings
SET line12=^* ^* Secret keys
SET line13=^* ^* Database table prefix
SET line14=^* ^* ABSPATH
SET line15=^*
SET line16=^* @link https://wordpress.org/support/article/editing-wp-config-php/
SET line17=^*
SET line18=^* @package WordPress
SET line19=^*/

SET line21=// ^*^* MySQL settings - You can get this info from your web host ^*^* //
SET line22=/^* ^* The name of the database for WordPress ^*/
SET line23=define( 'DB_NAME', '%databaseName%' );

SET line25=/^*^* MySQL database username ^*/
SET line26=define( 'DB_USER', 'root' );

SET line28=/^*^* MySQL database password ^*/
SET line29=define( 'DB_PASSWORD', '' );

SET line31=/^*^* MySQL hostname ^*/
SET line32=define( 'DB_HOST', 'localhost' );

SET line34=/^*^* Database charset to use in creating database tables. ^*/
SET line35=^define( 'DB_CHARSET', 'utf8mb4' );

SET line37=/^* ^* The database collate type. Don't change this if in doubt. ^*/
SET line38=^define( 'DB_COLLATE', '' );

SET line40=/^*^*#@^+
SET line41= ^* Authentication unique keys and salts.
SET line42= ^*
SET line43= ^* Change these to different unique phrases! You can generate these using
SET line44= ^* the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
SET line45= ^*
SET line46= ^* You can change these at any point in time to invalidate all existing cookies.
SET line47= ^* This will force all users to have to log in again.
SET line48= ^*
SET line49= ^* @since 2.6.0
SET line50= ^*/
SET line51=define( 'AUTH_KEY',         '' );
SET line52=define( 'SECURE_AUTH_KEY',  '' );
SET line53=define( 'LOGGED_IN_KEY',    '' );
SET line54=define( 'NONCE_KEY',        '' );
SET line55=define( 'AUTH_SALT',        '' );
SET line56=define( 'SECURE_AUTH_SALT', '' );
SET line57=define( 'LOGGED_IN_SALT',   '' );
SET line58=define( 'NONCE_SALT',       '' );

SET line60=/^*^*#@-^*/

SET line62=/^*^*
SET line63=^* WordPress database table prefix.
SET line64=^*
SET line65=^* You can have multiple installations in one database if you give each
SET line66=^* a unique prefix. Only numbers, letters, and underscores please!
SET line67=^*/

SET line70=/^*^*
SET line71=^* For developers: WordPress debugging mode.
SET line72=^*
SET line73=^* Change this to true to enable the display of notices during development.
SET line74=^* It is strongly recommended that plugin and theme developers use WP_DEBUG
SET line75=^* in their development environments.
SET line76=^*
SET line77=^* For information on other constants that can be used for debugging,
SET line78=^* visit the documentation.
SET line79=^*
SET line80=^* @link https://wordpress.org/support/article/debugging-in-wordpress/
SET line81=^*/
SET line82=define('WP_DEBUG', false );

SET line87=/^* Add any custom values between this line and the "stop editing" line. ^*/

SET line91=/^* That's all, stop editing! Happy publishing. ^*/

SET line93=/^*^* Absolute path to the WordPress directory. ^*/
SET line94=if ( ! defined( 'ABSPATH' ) ) {
SET line95=	define( 'ABSPATH', __DIR__ . '/' );
SET line96=}

SET line98=/^*^* Sets up WordPress vars and included files. ^*/
SET line99=require_once ABSPATH . 'wp-settings.php';


echo.>wp-config.php
echo ^<?php>>wp-config.php
echo %line2%>>wp-config.php
echo %line3%>>wp-config.php
echo %line4%>>wp-config.php
echo %line5%>>wp-config.php
echo %line6%>>wp-config.php
echo %line7%>>wp-config.php
echo %line8%>>wp-config.php
echo %line9%>>wp-config.php
echo %line10%>>wp-config.php
echo %line11%>>wp-config.php
echo %line12%>>wp-config.php
echo %line13%>>wp-config.php
echo %line14%>>wp-config.php
echo %line15%>>wp-config.php
echo %line16%>>wp-config.php
echo %line17%>>wp-config.php
echo %line18%>>wp-config.php
echo %line19%>>wp-config.php
echo.>>wp-config.php
echo %line21%>>wp-config.php
echo %line22%>>wp-config.php
echo %line23%>>wp-config.php
echo.>>wp-config.php
echo %line25%>>wp-config.php
echo %line26%>>wp-config.php
echo.>>wp-config.php
echo %line28%>>wp-config.php
echo %line29%>>wp-config.php
echo.>>wp-config.php
echo %line31%>>wp-config.php
echo %line32%>>wp-config.php
echo.>>wp-config.php
echo %line34%>>wp-config.php
echo %line35%>>wp-config.php
echo.>>wp-config.php
echo %line37%>>wp-config.php
echo %line38%>>wp-config.php
echo.>>wp-config.php
echo %line40%>>wp-config.php
echo %line41%>>wp-config.php
echo %line42%>>wp-config.php
echo %line43%>>wp-config.php
echo %line44%>>wp-config.php
echo %line45%>>wp-config.php
echo %line46%>>wp-config.php
echo %line47%>>wp-config.php
echo %line48%>>wp-config.php
echo %line49%>>wp-config.php
echo %line50%>>wp-config.php
echo %line51%>>wp-config.php
echo %line52%>>wp-config.php
echo %line53%>>wp-config.php
echo %line54%>>wp-config.php
echo %line55%>>wp-config.php
echo %line56%>>wp-config.php
echo %line57%>>wp-config.php
echo %line58%>>wp-config.php
echo.>>wp-config.php
echo %line60%>>wp-config.php
echo.>>wp-config.php
echo %line62%>>wp-config.php
echo %line63%>>wp-config.php
echo %line64%>>wp-config.php
echo %line65%>>wp-config.php
echo %line66%>>wp-config.php
echo %line67%>>wp-config.php
echo %tablePrefix%>>wp-config.php
echo.>>wp-config.php
echo %line70%>>wp-config.php
echo %line71%>>wp-config.php
echo %line72%>>wp-config.php
echo %line73%>>wp-config.php
echo %line74%>>wp-config.php
echo %line75%>>wp-config.php
echo %line76%>>wp-config.php
echo %line77%>>wp-config.php
echo %line78%>>wp-config.php
echo %line79%>>wp-config.php
echo %line80%>>wp-config.php
echo %line81%>>wp-config.php
echo.>>wp-config.php
echo %line82%>>wp-config.php
echo %uploads%>>wp-config.php
echo %WP_HOME%>>wp-config.php
echo %WP_SITEURL%>>wp-config.php
echo.>>wp-config.php
echo %line87%>>wp-config.php
echo %line91%>>wp-config.php
echo.>>wp-config.php
echo %line93%>>wp-config.php
echo %line94%>>wp-config.php
echo %line95%>>wp-config.php
echo %line96%>>wp-config.php
echo.>>wp-config.php
echo %line98%>>wp-config.php
echo %line99%>>wp-config.php
echo.>>wp-config.php
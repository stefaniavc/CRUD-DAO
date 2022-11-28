-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema funcionarios_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema funcionarios_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `funcionarios_db` DEFAULT CHARACTER SET utf8 ;
USE `funcionarios_db` ;

-- -----------------------------------------------------
-- Table `funcionarios_db`.`tipos_identificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `funcionarios_db`.`tipos_identificacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funcionarios_db`.`estado_civil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `funcionarios_db`.`estado_civil` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funcionarios_db`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `funcionarios_db`.`funcionarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero_identificacion` VARCHAR(45) NOT NULL,
  `nombres` VARCHAR(120) NOT NULL,
  `apellidos` VARCHAR(120) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado_civil` VARCHAR(45) NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `direccion` VARCHAR(250) NOT NULL,
  `telefono` VARCHAR(255) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `fecha_creacion` DATETIME NOT NULL DEFAULT NOW(),
  `fecha_actualizacion` DATETIME NOT NULL DEFAULT NOW(),
  `tipos_identificacion_id` INT NOT NULL,
  `estado_civil_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `numero_identificacion_UNIQUE` (`numero_identificacion` ASC) VISIBLE,
  INDEX `fk_funcionarios_tipos_identificacion_idx` (`tipos_identificacion_id` ASC, `id` ASC) VISIBLE,
  INDEX `fk_funcionarios_estados_civiles1_idx` (`estado_civil_id` ASC) VISIBLE,
  CONSTRAINT `fk_funcionarios_tipos_identificacion`
    FOREIGN KEY (`tipos_identificacion_id` , `id`)
    REFERENCES `funcionarios_db`.`tipos_identificacion` (`id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionarios_estado_civil1`
    FOREIGN KEY (`estado_civil_id`)
    REFERENCES `funcionarios_db`.`estado_civil` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `funcionarios_db`.`parentesco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `funcionarios_db`.`parentesco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  `fecha_creacion` DATETIME NOT NULL DEFAULT NOW(),
  `fecha_actualizacion` DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funcionarios_db`.`grupo_familiar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `funcionarios_db`.`grupo_familiar` (
  `nombre` VARCHAR(120) NOT NULL,
  `apellido` VARCHAR(120) NOT NULL,
  `direccion` VARCHAR(250) NOT NULL,
  `parentesco` VARCHAR(120) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_creacion` DATETIME NOT NULL DEFAULT NOW(),
  `fecha_actualizacion` DATETIME NOT NULL DEFAULT NOW(),
  `funcionarios_id` INT NOT NULL,
  `parentesco_id` INT NOT NULL,
  INDEX `fk_grupo_familiar_funcionarios1_idx` (`funcionarios_id` ASC) VISIBLE,
  INDEX `fk_grupo_familiar_parentesco1_idx` (`parentesco_id` ASC) VISIBLE,
  CONSTRAINT `fk_grupo_familiar_funcionarios1`
    FOREIGN KEY (`funcionarios_id`)
    REFERENCES `funcionarios_db`.`funcionarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupo_familiar_parentesco1`
    FOREIGN KEY (`parentesco_id`)
    REFERENCES `funcionarios_db`.`parentesco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
PACK_KEYS = Default;


-- -----------------------------------------------------
-- Table `funcionarios_db`.`nivel_academico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `funcionarios_db`.`nivel_academico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(120) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funcionarios_db`.`estado_formacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `funcionarios_db`.`estado_formacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(120) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funcionarios_db`.`universidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `funcionarios_db`.`universidad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(120) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  `fecha_creacion` DATETIME NOT NULL,
  `fecha_actualizacion` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funcionarios_db`.`formacion_academica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `funcionarios_db`.`formacion_academica` (
  `id` INT ZEROFILL NOT NULL,
  `fecha_inicio` DATETIME NOT NULL,
  `fecha_final` DATETIME NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `nivel` VARCHAR(45) NOT NULL,
  `universidad` VARCHAR(250) NOT NULL,
  `fecha_creacion` DATETIME NOT NULL,
  `fecha_actualizacion` DATETIME NOT NULL,
  `funcionarios_id` INT NOT NULL,
  `nivel_academico_id` INT NOT NULL,
  `estado_formacion_id` INT NOT NULL,
  `universidad_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_formacion_academica_funcionarios1_idx` (`funcionarios_id` ASC) VISIBLE,
  INDEX `fk_formacion_academica_nivel_academico1_idx` (`nivel_academico_id` ASC) VISIBLE,
  INDEX `fk_formacion_academica_estado_formacion1_idx` (`estado_formacion_id` ASC) VISIBLE,
  INDEX `fk_formacion_academica_universidad1_idx` (`universidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_formacion_academica_funcionarios1`
    FOREIGN KEY (`funcionarios_id`)
    REFERENCES `funcionarios_db`.`funcionarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_formacion_academica_nivel_academico1`
    FOREIGN KEY (`nivel_academico_id`)
    REFERENCES `funcionarios_db`.`nivel_academico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_formacion_academica_estado_formacion1`
    FOREIGN KEY (`estado_formacion_id`)
    REFERENCES `funcionarios_db`.`estado_formacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_formacion_academica_universidad1`
    FOREIGN KEY (`universidad_id`)
    REFERENCES `funcionarios_db`.`universidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

USE `funcionarios_db` ;

-- -----------------------------------------------------
-- Placeholder table for view `funcionarios_db`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `funcionarios_db`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `funcionarios_db`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funcionarios_db`.`view1`;
USE `funcionarios_db`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `funcionarios_db`.`tipos_identificacion`
-- -----------------------------------------------------
START TRANSACTION;
USE `funcionarios_db`;
INSERT INTO `funcionarios_db`.`tipos_identificacion` (`id`, `nombre`, `descripcion`) VALUES (123456778987, 'Alba', 'Cedula Ciudadania');
INSERT INTO `funcionarios_db`.`tipos_identificacion` (`id`, `nombre`, `descripcion`) VALUES (456789087, 'Juan', 'Cedula Ciudadania');

COMMIT;


-- -----------------------------------------------------
-- Data for table `funcionarios_db`.`estado_civil`
-- -----------------------------------------------------
START TRANSACTION;
USE `funcionarios_db`;
INSERT INTO `funcionarios_db`.`estado_civil` (`id`, `nombre`, `descripcion`) VALUES (1245678970, 'Sol', 'Soltero');

COMMIT;


-- -----------------------------------------------------
-- Data for table `funcionarios_db`.`parentesco`
-- -----------------------------------------------------
START TRANSACTION;
USE `funcionarios_db`;
INSERT INTO `funcionarios_db`.`parentesco` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_actualizacion`) VALUES (13224565, 'PP', 'Papa', DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `funcionarios_db`.`grupo_familiar`
-- -----------------------------------------------------
START TRANSACTION;
USE `funcionarios_db`;
INSERT INTO `funcionarios_db`.`grupo_familiar` (`nombre`, `apellido`, `direccion`, `parentesco`, `fecha_creacion`, `fecha_actualizacion`, `funcionarios_id`, `parentesco_id`) VALUES ('Sury', 'Aguilar', 'Calle Siempre Viva 108', 'MM', DEFAULT, DEFAULT, 1345678788, DEFAULT);
INSERT INTO `funcionarios_db`.`grupo_familiar` (`nombre`, `apellido`, `direccion`, `parentesco`, `fecha_creacion`, `fecha_actualizacion`, `funcionarios_id`, `parentesco_id`) VALUES ('Marcos ', 'Delgado', 'Morrys 508 bb', 'PP', DEFAULT, DEFAULT, 13245657, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `funcionarios_db`.`nivel_academico`
-- -----------------------------------------------------
START TRANSACTION;
USE `funcionarios_db`;
INSERT INTO `funcionarios_db`.`nivel_academico` (`id`, `nombre`, `descripcion`) VALUES (1234356, 'otro', 'Otro Tipo Universidad');

COMMIT;


-- -----------------------------------------------------
-- Data for table `funcionarios_db`.`estado_formacion`
-- -----------------------------------------------------
START TRANSACTION;
USE `funcionarios_db`;
INSERT INTO `funcionarios_db`.`estado_formacion` (`id`, `nombre`, `descripcion`) VALUES (1234567889, 'EF', 'Estudios Finalizados');

COMMIT;


-- -----------------------------------------------------
-- Data for table `funcionarios_db`.`universidad`
-- -----------------------------------------------------
START TRANSACTION;
USE `funcionarios_db`;
INSERT INTO `funcionarios_db`.`universidad` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_actualizacion`) VALUES (12345787, 'Leo', 'IUD ', DEFAULT, DEFAULT);

COMMIT;


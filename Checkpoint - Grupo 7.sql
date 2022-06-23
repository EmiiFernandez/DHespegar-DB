-- MySQL Workbench Forward Engineering
-- INTEGRANTES:
-- EMILIA FERNANDEZ
-- VALENTINA GARCIA
-- WALTER GALE
-- JULIAN RE


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DHespegar
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DHespegar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DHespegar` DEFAULT CHARACTER SET utf8 ;
USE `DHespegar` ;

-- -----------------------------------------------------
-- Table `DHespegar`.`paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHespegar`.`paises` (
  `idpaises` INT NOT NULL AUTO_INCREMENT,
  `paises` VARCHAR(45) NULL,
  PRIMARY KEY (`idpaises`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHespegar`.`sucursales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHespegar`.`sucursales` (
  `idsucursales` INT NOT NULL AUTO_INCREMENT,
  `telefono` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `id_paises` INT NULL,
  PRIMARY KEY (`idsucursales`),
  INDEX `fk_sucursales_paises_idx` (`id_paises` ASC) VISIBLE,
  CONSTRAINT `fk_sucursales_paises`
    FOREIGN KEY (`id_paises`)
    REFERENCES `DHespegar`.`paises` (`idpaises`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHespegar`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHespegar`.`clientes` (
  `idclientes` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `num_pasaporte` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NULL,
  `id_paises` INT NULL,
  `telefono` VARCHAR(45) NULL,
  PRIMARY KEY (`idclientes`),
  UNIQUE INDEX `num_pasaporte_UNIQUE` (`num_pasaporte` ASC) VISIBLE,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE,
  INDEX `fk_clientes_paises_idx` (`id_paises` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_paises`
    FOREIGN KEY (`id_paises`)
    REFERENCES `DHespegar`.`paises` (`idpaises`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHespegar`.`metodo_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHespegar`.`metodo_pago` (
  `idmetodo_pago` INT NOT NULL AUTO_INCREMENT,
  `metodo_pago` VARCHAR(45) NULL,
  PRIMARY KEY (`idmetodo_pago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHespegar`.`pago_reservas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHespegar`.`pago_reservas` (
  `idpago_reservas` INT NOT NULL AUTO_INCREMENT,
  `monto_total` DECIMAL(15,2) NULL,
  `cantidad_cuotas` TINYINT NULL,
  `id_metodo_pago` INT NULL,
  PRIMARY KEY (`idpago_reservas`),
  INDEX `fk_pago_reservas_metodo_pago_idx` (`id_metodo_pago` ASC) VISIBLE,
  CONSTRAINT `fk_pago_reservas_metodo_pago`
    FOREIGN KEY (`id_metodo_pago`)
    REFERENCES `DHespegar`.`metodo_pago` (`idmetodo_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHespegar`.`reservas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHespegar`.`reservas` (
  `idreservas` INT NOT NULL AUTO_INCREMENT,
  `codigo_reserva` CHAR(6) NULL,
  `fecha_y_hora_reserva` DATETIME NULL,
  `id_sucursales` INT NULL,
  `id_clientes` INT NULL,
  `id_pago_reservas` INT NULL,
  PRIMARY KEY (`idreservas`),
  UNIQUE INDEX `codigo_reserva_UNIQUE` (`codigo_reserva` ASC) VISIBLE,
  INDEX `fk_reservas_sucursales_idx` (`id_sucursales` ASC) VISIBLE,
  INDEX `fk_reservas_clientes_idx` (`id_clientes` ASC) VISIBLE,
  INDEX `fk_reservas_pago_reservas_idx` (`id_pago_reservas` ASC) VISIBLE,
  CONSTRAINT `fk_reservas_sucursales`
    FOREIGN KEY (`id_sucursales`)
    REFERENCES `DHespegar`.`sucursales` (`idsucursales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_clientes`
    FOREIGN KEY (`id_clientes`)
    REFERENCES `DHespegar`.`clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_pago_reservas`
    FOREIGN KEY (`id_pago_reservas`)
    REFERENCES `DHespegar`.`pago_reservas` (`idpago_reservas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHespegar`.`vuelos_privados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHespegar`.`vuelos_privados` (
  `idvuelos_privados` INT NOT NULL AUTO_INCREMENT,
  `num_vuelo` CHAR(6) NOT NULL,
  `fecha_partida` DATETIME NOT NULL,
  `fecha_estimada_llegada` DATETIME NOT NULL,
  `ciudad_origen` VARCHAR(45) NOT NULL,
  `ciudad_destino` VARCHAR(45) NOT NULL,
  `plazas_c_turista` TINYINT NOT NULL,
  `plazas_primera_clase` TINYINT NOT NULL,
  PRIMARY KEY (`idvuelos_privados`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHespegar`.`hoteles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHespegar`.`hoteles` (
  `idhoteles` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `ciudad` VARCHAR(45) NULL,
  `id_paises` INT NULL,
  `telefono` VARCHAR(45) NULL,
  `cant_habitaciones` TINYINT NULL,
  PRIMARY KEY (`idhoteles`),
  INDEX `fk_hoteles_paises_idx` (`id_paises` ASC) VISIBLE,
  CONSTRAINT `fk_hoteles_paises`
    FOREIGN KEY (`id_paises`)
    REFERENCES `DHespegar`.`paises` (`idpaises`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHespegar`.`clase_vuelos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHespegar`.`clase_vuelos` (
  `idclase_vuelos` INT NOT NULL AUTO_INCREMENT,
  `clase_vuelo` VARCHAR(45) NULL,
  PRIMARY KEY (`idclase_vuelos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHespegar`.`tipo_vuelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHespegar`.`tipo_vuelo` (
  `idtipo_vuelo` INT NOT NULL AUTO_INCREMENT,
  `tipo_vuelo` VARCHAR(45) NULL,
  PRIMARY KEY (`idtipo_vuelo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHespegar`.`reservas_vuelos_privados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHespegar`.`reservas_vuelos_privados` (
  `idreservas_vuelos_privados` INT NOT NULL AUTO_INCREMENT,
  `id_reservas` INT NULL,
  `id_vuelos_privados` INT NULL,
  `id_clase_vuelos` INT NULL,
  `id_tipo_vuelo` INT NULL,
  PRIMARY KEY (`idreservas_vuelos_privados`),
  INDEX `fk_reservas_vuelos_privados_reservas_idx` (`id_reservas` ASC) VISIBLE,
  INDEX `fk_reservas_vuelos_privados_vuelos_privados_idx` (`id_vuelos_privados` ASC) VISIBLE,
  INDEX `fk_reservas_vuelos_privados_ clase_vuelos_idx` (`id_clase_vuelos` ASC) VISIBLE,
  INDEX `fk_reservas_vuelos_privados_tipo_vuelo_idx` (`id_tipo_vuelo` ASC) VISIBLE,
  CONSTRAINT `fk_reservas_vuelos_privados_reservas`
    FOREIGN KEY (`id_reservas`)
    REFERENCES `DHespegar`.`reservas` (`idreservas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_vuelos_privados_vuelos_privados`
    FOREIGN KEY (`id_vuelos_privados`)
    REFERENCES `DHespegar`.`vuelos_privados` (`idvuelos_privados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_vuelos_privados_ clase_vuelos`
    FOREIGN KEY (`id_clase_vuelos`)
    REFERENCES `DHespegar`.`clase_vuelos` (`idclase_vuelos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_vuelos_privados_tipo_vuelo`
    FOREIGN KEY (`id_tipo_vuelo`)
    REFERENCES `DHespegar`.`tipo_vuelo` (`idtipo_vuelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHespegar`.`tipo_hospedaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHespegar`.`tipo_hospedaje` (
  `idtipo_hospedaje` INT NOT NULL AUTO_INCREMENT,
  `tipo_pension` VARCHAR(45) NULL,
  PRIMARY KEY (`idtipo_hospedaje`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHespegar`.`hoteles_reservas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHespegar`.`hoteles_reservas` (
  `idhoteles_reservas` INT NOT NULL AUTO_INCREMENT,
  `id_hoteles` INT NULL,
  `id_reservas` INT NULL,
  `checkin` DATETIME NULL,
  `checkout` DATETIME NULL,
  `id_tipo_hospedaje` INT NULL,
  PRIMARY KEY (`idhoteles_reservas`),
  INDEX `fk_hoteles_reservas_hoteles_idx` (`id_hoteles` ASC) VISIBLE,
  INDEX `fk_hoteles_reservas_reservas_idx` (`id_reservas` ASC) VISIBLE,
  INDEX `fk_hoteles_reservas_tipo_hospedaje_idx` (`id_tipo_hospedaje` ASC) VISIBLE,
  CONSTRAINT `fk_hoteles_reservas_hoteles`
    FOREIGN KEY (`id_hoteles`)
    REFERENCES `DHespegar`.`hoteles` (`idhoteles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hoteles_reservas_reservas`
    FOREIGN KEY (`id_reservas`)
    REFERENCES `DHespegar`.`reservas` (`idreservas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hoteles_reservas_tipo_hospedaje`
    FOREIGN KEY (`id_tipo_hospedaje`)
    REFERENCES `DHespegar`.`tipo_hospedaje` (`idtipo_hospedaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

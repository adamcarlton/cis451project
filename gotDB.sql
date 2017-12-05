-- MySQL Script generated by MySQL Workbench
-- Mon Dec  4 21:07:20 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`great_houses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`great_houses` (
  `gh_id` INT NOT NULL,
  `gh_name` VARCHAR(45) NOT NULL,
  `gh_desc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`gh_id`),
  UNIQUE INDEX `gh_name_UNIQUE` (`gh_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`region` (
  `region_id` INT NOT NULL,
  `region_name` VARCHAR(45) NOT NULL,
  `region_desc` VARCHAR(45) NOT NULL,
  `controlled_by_gh` VARCHAR(45) NULL,
  PRIMARY KEY (`region_id`),
  INDEX `fk_region_great_houses1_idx` (`controlled_by_gh` ASC),
  CONSTRAINT `fk_region_great_houses1`
    FOREIGN KEY (`controlled_by_gh`)
    REFERENCES `mydb`.`great_houses` (`gh_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`important_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`important_location` (
  `location_id` INT NOT NULL,
  `location_name` VARCHAR(45) NOT NULL,
  `location_description` VARCHAR(45) NOT NULL,
  `location_in_region` INT NOT NULL,
  PRIMARY KEY (`location_id`),
  INDEX `fk_important_location_region1_idx` (`location_in_region` ASC),
  CONSTRAINT `fk_important_location_region1`
    FOREIGN KEY (`location_in_region`)
    REFERENCES `mydb`.`region` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`organization` (
  `org_id` INT NOT NULL,
  `org_name` VARCHAR(45) NOT NULL,
  `org_desc` VARCHAR(45) NOT NULL,
  `org_resides_in` INT NULL,
  PRIMARY KEY (`org_id`),
  INDEX `fk_organization_important_location1_idx` (`org_resides_in` ASC),
  CONSTRAINT `fk_organization_important_location1`
    FOREIGN KEY (`org_resides_in`)
    REFERENCES `mydb`.`important_location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`lesser_house`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`lesser_house` (
  `lh_id` INT NOT NULL,
  `lh_name` VARCHAR(45) NOT NULL,
  `bannerman_of_gh` VARCHAR(45) NOT NULL,
  `lh_resides_in` INT NOT NULL,
  PRIMARY KEY (`lh_id`),
  INDEX `fk_lesser_house_great_houses1_idx` (`bannerman_of_gh` ASC),
  INDEX `fk_lesser_house_region1_idx` (`lh_resides_in` ASC),
  CONSTRAINT `fk_lesser_house_great_houses1`
    FOREIGN KEY (`bannerman_of_gh`)
    REFERENCES `mydb`.`great_houses` (`gh_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lesser_house_region1`
    FOREIGN KEY (`lh_resides_in`)
    REFERENCES `mydb`.`region` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`person_of_interest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`person_of_interest` (
  `poi_id` INT NOT NULL,
  `poi_fname` VARCHAR(45) NOT NULL,
  `poi_lname` VARCHAR(45) NULL,
  `poi_desc` VARCHAR(45) NOT NULL,
  `poi_age` INT NULL,
  `poi_titles` VARCHAR(45) NULL,
  `poi_great_house` INT NULL,
  `poi_lesser_house` INT NULL,
  `organization_org_id` INT NULL,
  PRIMARY KEY (`poi_id`),
  INDEX `fk_person_of_interest_lesser_house1_idx` (`poi_lesser_house` ASC),
  INDEX `fk_person_of_interest_organization1_idx` (`organization_org_id` ASC),
  UNIQUE INDEX `poi_great_house_UNIQUE` (`poi_great_house` ASC),
  UNIQUE INDEX `poi_lesser_house_UNIQUE` (`poi_lesser_house` ASC),
  CONSTRAINT `fk_person_of_interest_great_houses1`
    FOREIGN KEY (`poi_great_house`)
    REFERENCES `mydb`.`great_houses` (`gh_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_of_interest_lesser_house1`
    FOREIGN KEY (`poi_lesser_house`)
    REFERENCES `mydb`.`lesser_house` (`lh_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_of_interest_organization1`
    FOREIGN KEY (`organization_org_id`)
    REFERENCES `mydb`.`organization` (`org_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`religion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`religion` (
  `relig_code` INT NOT NULL,
  `relig_name` VARCHAR(45) NOT NULL,
  `relig_desc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`relig_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`important_deaths`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`important_deaths` (
  `poi_id` INT NOT NULL,
  `death_description` VARCHAR(45) NOT NULL,
  INDEX `fk_important_deaths_person_of_interest1_idx` (`poi_id` ASC),
  CONSTRAINT `fk_important_deaths_person_of_interest1`
    FOREIGN KEY (`poi_id`)
    REFERENCES `mydb`.`person_of_interest` (`poi_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`battle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`battle` (
  `battle_id` INT NOT NULL,
  `battle_name` VARCHAR(45) NOT NULL,
  `battle_desc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`battle_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`fought_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`fought_in` (
  `poi_id` INT NOT NULL,
  `battle_id` INT NOT NULL,
  PRIMARY KEY (`poi_id`, `battle_id`),
  INDEX `fk_person_of_interest_has_battle_battle1_idx` (`battle_id` ASC),
  INDEX `fk_person_of_interest_has_battle_person_of_interest1_idx` (`poi_id` ASC),
  CONSTRAINT `fk_person_of_interest_has_battle_person_of_interest1`
    FOREIGN KEY (`poi_id`)
    REFERENCES `mydb`.`person_of_interest` (`poi_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_of_interest_has_battle_battle1`
    FOREIGN KEY (`battle_id`)
    REFERENCES `mydb`.`battle` (`battle_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`believes_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`believes_in` (
  `poi_id` INT NULL,
  `relig_code` INT NULL,
  PRIMARY KEY (`poi_id`, `relig_code`),
  INDEX `fk_person_of_interest_has_religion_religion1_idx` (`relig_code` ASC),
  INDEX `fk_person_of_interest_has_religion_person_of_interest1_idx` (`poi_id` ASC),
  CONSTRAINT `fk_person_of_interest_has_religion_person_of_interest1`
    FOREIGN KEY (`poi_id`)
    REFERENCES `mydb`.`person_of_interest` (`poi_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_of_interest_has_religion_religion1`
    FOREIGN KEY (`relig_code`)
    REFERENCES `mydb`.`religion` (`relig_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`great_house_allegiance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`great_house_allegiance` (
  `gh_id` INT NOT NULL,
  `gh_ally_id` INT NULL,
  PRIMARY KEY (`gh_id`, `gh_ally_id`),
  INDEX `fk_great_houses_has_great_houses_great_houses2_idx` (`gh_ally_id` ASC),
  INDEX `fk_great_houses_has_great_houses_great_houses1_idx` (`gh_id` ASC),
  CONSTRAINT `fk_great_houses_has_great_houses_great_houses1`
    FOREIGN KEY (`gh_id`)
    REFERENCES `mydb`.`great_houses` (`gh_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_great_houses_has_great_houses_great_houses2`
    FOREIGN KEY (`gh_ally_id`)
    REFERENCES `mydb`.`great_houses` (`gh_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

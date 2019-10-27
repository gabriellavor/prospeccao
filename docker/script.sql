CREATE DATABASE scorelea_prospeccao
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema scorelea_prospeccao
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `scorelea_prospeccao` DEFAULT CHARACTER SET utf8 ;
USE `scorelea_prospeccao` ;

  -- -----------------------------------------------------
-- Table `scorelea_prospeccao`.`lead`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scorelea_prospeccao`.`lead` (
  `lead_codigo` INT NOT NULL AUTO_INCREMENT,
  `lead_razao_social` VARCHAR(200) NOT NULL,
  `lead_cnpj` VARCHAR(14) NOT NULL,
  `lead_ativo` TINYINT(1) NULL DEFAULT 1,
  `lead_porcentagem` DECIMAL(20,15) NOT NULL,
  `lead_rua` VARCHAR(255) NULL,
  `lead_bairro` VARCHAR(45) BINARY NULL,
  `lead_cidade` VARCHAR(45) NULL,
  `lead_uf` VARCHAR(45) NULL,
  `lead_cep` VARCHAR(10) NULL,
  PRIMARY KEY (`lead_codigo`),
  UNIQUE INDEX `lead_cnpj_UNIQUE` (`lead_cnpj` ASC))
ENGINE = InnoDB;



  -- -----------------------------------------------------
-- Table `scorelea_prospeccao`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scorelea_prospeccao`.`cliente` (
  `clie_codigo` INT NOT NULL AUTO_INCREMENT,
  `clie_razao_social` VARCHAR(200) NOT NULL,
  `clie_cnpj` VARCHAR(14) NOT NULL,
  `clie_ativo` TINYINT(1) NULL DEFAULT 1,
  `clie_lead_codigo` INT NULL,
  `clie_execao` INT NULL DEFAULT 0,
  PRIMARY KEY (`clie_codigo`),
  INDEX `fk_cliente_lead_idx` (`clie_lead_codigo` ASC),
  UNIQUE INDEX `clie_cnpj_UNIQUE` (`clie_cnpj` ASC),
  CONSTRAINT `fk_cliente_lead`
    FOREIGN KEY (`clie_lead_codigo`)
    REFERENCES `scorelea_prospeccao`.`lead` (`lead_codigo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


  -- -----------------------------------------------------
  -- Table `scorelea_prospeccao`.`cnae`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `scorelea_prospeccao`.`cnae` (
    `cnae_codigo` INT NOT NULL AUTO_INCREMENT,
    `cnae_codigo_cnae` VARCHAR(15) NOT NULL,
    `cnae_descricao` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`cnae_codigo`))
  ENGINE = InnoDB;


  -- -----------------------------------------------------
  -- Table `scorelea_prospeccao`.`tipo_contato`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `scorelea_prospeccao`.`tipo_contato` (
    `tcon_codigo` INT NOT NULL AUTO_INCREMENT,
    `tcon_descricao` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`tcon_codigo`))
  ENGINE = InnoDB;


  -- -----------------------------------------------------
  -- Table `scorelea_prospeccao`.`contato`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `scorelea_prospeccao`.`contato` (
    `cont_lead_codigo` INT NOT NULL,
    `cont_tcon_codigo` INT NOT NULL,
    `cont_descricao` VARCHAR(45) NOT NULL,
    INDEX `fk_contato_tcon_idx` (`cont_tcon_codigo` ASC),
    INDEX `fk_contato_lead_idx` (`cont_lead_codigo` ASC),
    CONSTRAINT `fk_contato_tcon`
      FOREIGN KEY (`cont_tcon_codigo`)
      REFERENCES `scorelea_prospeccao`.`tipo_contato` (`tcon_codigo`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    CONSTRAINT `fk_contato_lead`
      FOREIGN KEY (`cont_lead_codigo`)
      REFERENCES `scorelea_prospeccao`.`lead` (`lead_codigo`)
      ON DELETE CASCADE
      ON UPDATE CASCADE)
  ENGINE = InnoDB;


  -- -----------------------------------------------------
  -- Table `scorelea_prospeccao`.`lead_cnae`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `scorelea_prospeccao`.`lead_cnae` (
    `lcna_lead_codigo` INT NOT NULL,
    `lcna_cnae_codigo` INT NOT NULL,
    INDEX `fk_lcna_cnae_idx` (`lcna_cnae_codigo` ASC),
    INDEX `fk_lcna_lead_idx` (`lcna_lead_codigo` ASC),
    CONSTRAINT `fk_lcna_cnae`
      FOREIGN KEY (`lcna_cnae_codigo`)
      REFERENCES `scorelea_prospeccao`.`cnae` (`cnae_codigo`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    CONSTRAINT `fk_lcna_lead`
      FOREIGN KEY (`lcna_lead_codigo`)
      REFERENCES `scorelea_prospeccao`.`lead` (`lead_codigo`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION)
  ENGINE = InnoDB;


  -- -----------------------------------------------------
  -- Table `scorelea_prospeccao`.`facebook`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `scorelea_prospeccao`.`facebook` (
    `face_codigo` INT NOT NULL AUTO_INCREMENT,
    `face_nome` VARCHAR(45) NOT NULL,
    `face_email` VARCHAR(45) NULL,
    `face_site` VARCHAR(45) NULL,
    `face_telefone` VARCHAR(45) NULL,
    `face_lead_codigo` INT NULL,
    PRIMARY KEY (`face_codigo`),
    INDEX `fk_facebook_lead_idx` (`face_lead_codigo` ASC),
    CONSTRAINT `fk_facebook_lead`
      FOREIGN KEY (`face_lead_codigo`)
      REFERENCES `scorelea_prospeccao`.`lead` (`lead_codigo`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION)
  ENGINE = InnoDB;


  -- -----------------------------------------------------
  -- Table `scorelea_prospeccao`.`cliente_cnae`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `scorelea_prospeccao`.`cliente_cnae` (
    `ccna_clie_codigo` INT NOT NULL,
    `ccna_cnae_codigo` INT NOT NULL,
    INDEX `fk_cliente_cnae_cliente_idx` (`ccna_clie_codigo` ASC),
    INDEX `fk_cliente_cnae_cnae_idx` (`ccna_cnae_codigo` ASC),
    CONSTRAINT `fk_cliente_cnae_cliente`
      FOREIGN KEY (`ccna_clie_codigo`)
      REFERENCES `scorelea_prospeccao`.`cliente` (`clie_codigo`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    CONSTRAINT `fk_cliente_cnae_cnae`
      FOREIGN KEY (`ccna_cnae_codigo`)
      REFERENCES `scorelea_prospeccao`.`cnae` (`cnae_codigo`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION)
  ENGINE = InnoDB;


  -- -----------------------------------------------------
  -- Table `scorelea_prospeccao`.`usuario`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `scorelea_prospeccao`.`usuario` (
    `usua_codigo` INT NOT NULL AUTO_INCREMENT,
    `usua_nome` VARCHAR(45) NOT NULL,
    `usua_ativo` INT NULL DEFAULT 1,
    `usua_admin` INT NULL,
    `usua_email` VARCHAR(45) NOT NULL,
    `usua_senha` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`usua_codigo`),
    UNIQUE INDEX `usua_email_UNIQUE` (`usua_email` ASC))
  ENGINE = InnoDB;


  -- -----------------------------------------------------
  -- Table `scorelea_prospeccao`.`termo`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `scorelea_prospeccao`.`termo` (
  `term_codigo` INT NOT NULL AUTO_INCREMENT,
  `term_descricao` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`term_codigo`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `scorelea_prospeccao`.`configuracao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scorelea_prospeccao`.`configuracao` (
  `conf_porcentagem` INT NOT NULL)
ENGINE = InnoDB;





SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.11-3/01","Cultivo de arroz");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.11-3/02","Cultivo de milho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.11-3/03","Cultivo de trigo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.11-3/99","Cultivo de outros cereais não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.12-1/01","Cultivo de algodão herbáceo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.12-1/02","Cultivo de juta");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.12-1/99","Cultivo de outras fibras de lavoura temporária não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.13-0/00","Cultivo de cana-de-açúcar");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.14-8/00","Cultivo de fumo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.15-6/00","Cultivo de soja");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.16-4/01","Cultivo de amendoim");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.16-4/02","Cultivo de girassol");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.16-4/03","Cultivo de mamona");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.16-4/99","Cultivo de outras oleaginosas de lavoura temporária não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.19-9/01","Cultivo de abacaxi");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.19-9/02","Cultivo de alho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.19-9/03","Cultivo de batata-inglesa");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.19-9/04","Cultivo de cebola");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.19-9/05","Cultivo de feijão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.19-9/06","Cultivo de mandioca");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.19-9/07","Cultivo de melão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.19-9/08","Cultivo de melancia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.19-9/09","Cultivo de tomate rasteiro");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.19-9/99","Cultivo de outras plantas de lavoura temporária não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.21-1/01","Horticultura, exceto morango");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.21-1/02","Cultivo de morango");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.22-9/00","Cultivo de flores e plantas ornamentais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.31-8/00","Cultivo de laranja");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.32-6/00","Cultivo de uva");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.33-4/01","Cultivo de açaí");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.33-4/02","Cultivo de banana");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.33-4/03","Cultivo de caju");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.33-4/04","Cultivo de cítricos, exceto laranja");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.33-4/05","Cultivo de coco-da-baía");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.33-4/06","Cultivo de guaraná");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.33-4/07","Cultivo de maçã");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.33-4/08","Cultivo de mamão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.33-4/09","Cultivo de maracujá");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.33-4/10","Cultivo de manga");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.33-4/11","Cultivo de pêssego");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.33-4/99","Cultivo de frutas de lavoura permanente não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.34-2/00","Cultivo de café");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.35-1/00","Cultivo de cacau");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.39-3/01","Cultivo de chá-da-índia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.39-3/02","Cultivo de erva-mate");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.39-3/03","Cultivo de pimenta-do-reino");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.39-3/04","Cultivo de plantas para condimento, exceto pimenta-do-reino");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.39-3/05","Cultivo de dendê");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.39-3/06","Cultivo de seringueira");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.39-3/99","Cultivo de outras plantas de lavoura permanente não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.41-5/01","Produção de sementes certificadas, exceto de forrageiras para pasto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.41-5/02","Produção de sementes certificadas de forrageiras para formação de pasto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.42-3/00","Produção de mudas e outras formas de propagação vegetal, certificadas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.51-2/01","Criação de bovinos para corte");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.51-2/02","Criação de bovinos para leite");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.51-2/03","Criação de bovinos, exceto para corte e leite");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.52-1/01","Criação de bufalinos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.52-1/02","Criação de eqüinos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.52-1/03","Criação de asininos e muares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.53-9/01","Criação de caprinos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.53-9/02","Criação de ovinos, inclusive para produção de lã");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.54-7/00","Criação de suínos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.55-5/01","Criação de frangos para corte");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.55-5/02","Produção de pintos de um dia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.55-5/03","Criação de outros galináceos, exceto para corte");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.55-5/04","Criação de aves, exceto galináceos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.55-5/05","Produção de ovos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.59-8/01","Apicultura");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.59-8/02","Criação de animais de estimação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.59-8/03","Criação de escargô");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.59-8/04","Criação de bicho-da-seda");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.59-8/99","Criação de outros animais não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.61-0/01","Serviço de pulverização e controle de pragas agrícolas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.61-0/02","Serviço de poda de árvores para lavouras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.61-0/03","Serviço de preparação de terreno, cultivo e colheita");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.61-0/99","Atividades de apoio à agricultura não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.62-8/01","Serviço de inseminação artificial em animais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.62-8/02","Serviço de tosquiamento de ovinos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.62-8/03","Serviço de manejo de animais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.62-8/99","Atividades de apoio à pecuária não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.63-6/00","Atividades de pós-colheita");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("01.70-9/00","Caça e serviços relacionados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.10-1/01","Cultivo de eucalipto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.10-1/02","Cultivo de acácia-negra");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.10-1/03","Cultivo de pinus");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.10-1/04","Cultivo de teca");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.10-1/05","Cultivo de espécies madeireiras, exceto eucalipto, acácia-negra, pinus e teca");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.10-1/06","Cultivo de mudas em viveiros florestais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.10-1/07","Extração de madeira em florestas plantadas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.10-1/08","Produção de carvão vegetal - florestas plantadas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.10-1/09","Produção de casca de acácia-negra - florestas plantadas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.10-1/99","Produção de produtos não-madeireiros não especificados anteriormente em florestas plantadas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.20-9/01","Extração de madeira em florestas nativas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.20-9/02","Produção de carvão vegetal - florestas nativas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.20-9/03","Coleta de castanha-do-pará em florestas nativas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.20-9/04","Coleta de látex em florestas nativas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.20-9/05","Coleta de palmito em florestas nativas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.20-9/06","Conservação de florestas nativas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.20-9/99","Coleta de produtos não-madeireiros não especificados anteriormente em florestas nativas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("02.30-6/00","Atividades de apoio à produção florestal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.11-6/01","Pesca de peixes em água salgada");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.11-6/02","Pesca de crustáceos e moluscos em água salgada");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.11-6/03","Coleta de outros produtos marinhos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.11-6/04","Atividades de apoio à pesca em água salgada");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.12-4/01","Pesca de peixes em água doce");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.12-4/02","Pesca de crustáceos e moluscos em água doce");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.12-4/03","Coleta de outros produtos aquáticos de água doce");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.12-4/04","Atividades de apoio à pesca em água doce");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.21-3/01","Criação de peixes em água salgada e salobra");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.21-3/02","Criação de camarões em água salgada e salobra");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.21-3/03","Criação de ostras e mexilhões em água salgada e salobra");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.21-3/04","Criação de peixes ornamentais em água salgada e salobra");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.21-3/05","Atividades de apoio à aqüicultura em água salgada e salobra");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.21-3/99","Cultivos e semicultivos da aqüicultura em água salgada e salobra não especificados nteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.22-1/01","Criação de peixes em água doce");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.22-1/02","Criação de camarões em água doce");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.22-1/03","Criação de ostras e mexilhões em água doce");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.22-1/04","Criação de peixes ornamentais em água doce");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.22-1/05","Ranicultura");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.22-1/06","Criação de jacaré");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.22-1/07","Atividades de apoio à aqüicultura em água doce");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("03.22-1/99","Cultivos e semicultivos da aqüicultura em água doce não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("05.00-3/01","Extração de carvão mineral");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("05.00-3/02","Beneficiamento de carvão mineral");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("06.00-0/01","Extração de petróleo e gás natural");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("06.00-0/02","Extração e beneficiamento de xisto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("06.00-0/03","Extração e beneficiamento de areias betuminosas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.10-3/01","Extração de minério de ferro");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.10-3/02","Pelotização, sinterização e outros beneficiamentos de minério de ferro");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.21-9/01","Extração de minério de alumínio");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.21-9/02","Beneficiamento de minério de alumínio");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.22-7/01","Extração de minério de estanho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.22-7/02","Beneficiamento de minério de estanho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.23-5/01","Extração de minério de manganês");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.23-5/02","Beneficiamento de minério de manganês");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.24-3/01","Extração de minério de metais preciosos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.24-3/02","Beneficiamento de minério de metais preciosos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.25-1/00","Extração de minerais radioativos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.29-4/01","Extração de minérios de nióbio e titânio");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.29-4/02","Extração de minério de tungstênio");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.29-4/03","Extração de minério de níquel");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.29-4/04","Extração de minérios de cobre, chumbo, zinco e outros minerais metálicos não-ferrosos não specificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("07.29-4/05","Beneficiamento de minérios de cobre, chumbo, zinco e outros minerais metálicos não-ferrosos ão especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.10-0/01","Extração de ardósia e beneficiamento associado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.10-0/02","Extração de granito e beneficiamento associado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.10-0/03","Extração de mármore e beneficiamento associado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.10-0/04","Extração de calcário e dolomita e beneficiamento associado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.10-0/05","Extração de gesso e caulim");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.10-0/06","Extração de areia, cascalho ou pedregulho e beneficiamento associado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.10-0/07","Extração de argila e beneficiamento associado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.10-0/08","Extração de saibro e beneficiamento associado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.10-0/09","Extração de basalto e beneficiamento associado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.10-0/10","Beneficiamento de gesso e caulim associado à extração");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.10-0/99","Extração e britamento de pedras e outros materiais para construção e beneficiamento ssociado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.91-6/00","Extração de minerais para fabricação de adubos, fertilizantes e outros produtos químicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.92-4/01","Extração de sal marinho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.92-4/02","Extração de sal-gema");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.92-4/03","Refino e outros tratamentos do sal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.93-2/00","Extração de gemas (pedras preciosas e semipreciosas)");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.99-1/01","Extração de grafita");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.99-1/02","Extração de quartzo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.99-1/03","Extração de amianto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("08.99-1/99","Extração de outros minerais não-metálicos não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("09.10-6/00","Atividades de apoio à extração de petróleo e gás natural");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("09.90-4/01","Atividades de apoio à extração de minério de ferro");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("09.90-4/02","Atividades de apoio à extração de minerais metálicos não-ferrosos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("09.90-4/03","Atividades de apoio à extração de minerais não-metálicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.11-2/01","Frigorífico - abate de bovinos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.11-2/02","Frigorífico - abate de eqüinos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.11-2/03","Frigorífico - abate de ovinos e caprinos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.11-2/04","Frigorífico - abate de bufalinos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.11-2/05","Matadouro - abate de reses sob contrato - exceto abate de suínos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.12-1/01","Abate de aves");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.12-1/02","Abate de pequenos animais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.12-1/03","Frigorífico - abate de suínos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.12-1/04","Matadouro - abate de suínos sob contrato");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.13-9/01","Fabricação de produtos de carne");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.13-9/02","Preparação de subprodutos do abate");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.20-1/01","Preservação de peixes, crustáceos e moluscos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.20-1/02","Fabricação de conservas de peixes, crustáceos e moluscos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.31-7/00","Fabricação de conservas de frutas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.32-5/01","Fabricação de conservas de palmito");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.32-5/99","Fabricação de conservas de legumes e outros vegetais, exceto palmito");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.33-3/01","Fabricação de sucos concentrados de frutas, hortaliças e legumes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.33-3/02","Fabricação de sucos de frutas, hortaliças e legumes, exceto concentrados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.41-4/00","Fabricação de óleos vegetais em bruto, exceto óleo de milho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.42-2/00","Fabricação de óleos vegetais refinados, exceto óleo de milho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.43-1/00","Fabricação de margarina e outras gorduras vegetais e de óleos não-comestíveis de animais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.51-1/00","Preparação do leite");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.52-0/00","Fabricação de laticínios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.53-8/00","Fabricação de sorvetes e outros gelados comestíveis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.61-9/01","Beneficiamento de arroz");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.61-9/02","Fabricação de produtos do arroz");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.62-7/00","Moagem de trigo e fabricação de derivados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.63-5/00","Fabricação de farinha de mandioca e derivados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.64-3/00","Fabricação de farinha de milho e derivados, exceto óleos de milho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.65-1/01","Fabricação de amidos e féculas de vegetais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.65-1/02","Fabricação de óleo de milho em bruto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.65-1/03","Fabricação de óleo de milho refinado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.66-0/00","Fabricação de alimentos para animais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.69-4/00","Moagem e fabricação de produtos de origem vegetal não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.71-6/00","Fabricação de açúcar em bruto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.72-4/01","Fabricação de açúcar de cana refinado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.72-4/02","Fabricação de açúcar de cereais (dextrose) e de beterraba");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.81-3/01","Beneficiamento de café");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.81-3/02","Torrefação e moagem de café");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.82-1/00","Fabricação de produtos à base de café");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.91-1/01","Fabricação de produtos de panificação industrial");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.91-1/02","Fabricação de produtos de padaria e confeitaria com predominância de produção própria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.92-9/00","Fabricação de biscoitos e bolachas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.93-7/01","Fabricação de produtos derivados do cacau e de chocolates");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.93-7/02","Fabricação de frutas cristalizadas, balas e semelhantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.94-5/00","Fabricação de massas alimentícias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.95-3/00","Fabricação de especiarias, molhos, temperos e condimentos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.96-1/00","Fabricação de alimentos e pratos prontos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.99-6/01","Fabricação de vinagres");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.99-6/02","Fabricação de pós alimentícios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.99-6/03","Fabricação de fermentos e leveduras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.99-6/04","Fabricação de gelo comum");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.99-6/05","Fabricação de produtos para infusão (chá, mate, etc.)");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.99-6/06","Fabricação de adoçantes naturais e artificiais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.99-6/07","Fabricação de alimentos dietéticos e complementos alimentares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("10.99-6/99","Fabricação de outros produtos alimentícios não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("11.11-9/01","Fabricação de aguardente de cana-de-açúcar");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("11.11-9/02","Fabricação de outras aguardentes e bebidas destiladas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("11.12-7/00","Fabricação de vinho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("11.13-5/01","Fabricação de malte, inclusive malte uísque");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("11.13-5/02","Fabricação de cervejas e chopes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("11.21-6/00","Fabricação de águas envasadas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("11.22-4/01","Fabricação de refrigerantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("11.22-4/02","Fabricação de chá mate e outros chás prontos para consumo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("11.22-4/03","Fabricação de refrescos, xaropes e pós para refrescos, exceto refrescos de frutas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("11.22-4/04","Fabricação de bebidas isotônicas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("11.22-4/99","Fabricação de outras bebidas não-alcoólicas não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("12.10-7/00","Processamento industrial do fumo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("12.20-4/01","Fabricação de cigarros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("12.20-4/02","Fabricação de cigarrilhas e charutos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("12.20-4/03","Fabricação de filtros para cigarros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("12.20-4/99","Fabricação de outros produtos do fumo, exceto cigarros, cigarrilhas e charutos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.11-1/00","Preparação e fiação de fibras de algodão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.12-0/00","Preparação e fiação de fibras têxteis naturais, exceto algodão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.13-8/00","Fiação de fibras artificiais e sintéticas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.14-6/00","Fabricação de linhas para costurar e bordar");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.21-9/00","Tecelagem de fios de algodão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.22-7/00","Tecelagem de fios de fibras têxteis naturais, exceto algodão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.23-5/00","Tecelagem de fios de fibras artificiais e sintéticas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.30-8/00","Fabricação de tecidos de malha");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.40-5/01","Estamparia e texturização em fios, tecidos, artefatos têxteis e peças do vestuário");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.40-5/02","Alvejamento, tingimento e torção em fios, tecidos, artefatos têxteis e peças do vestuário");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.40-5/99","Outros serviços de acabamento em fios, tecidos, artefatos têxteis e peças do vestuário");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.51-1/00","Fabricação de artefatos têxteis para uso doméstico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.52-9/00","Fabricação de artefatos de tapeçaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.53-7/00","Fabricação de artefatos de cordoaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.54-5/00","Fabricação de tecidos especiais, inclusive artefatos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("13.59-6/00","Fabricação de outros produtos têxteis não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("14.11-8/01","Confecção de roupas íntimas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("14.11-8/02","Facção de roupas íntimas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("14.12-6/01","Confecção de peças de vestuário, exceto roupas íntimas e as confeccionadas sob medida");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("14.12-6/02","Confecção, sob medida, de peças do vestuário, exceto roupas íntimas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("14.12-6/03","Facção de peças do vestuário, exceto roupas íntimas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("14.13-4/01","Confecção de roupas profissionais, exceto sob medida");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("14.13-4/02","Confecção, sob medida, de roupas profissionais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("14.13-4/03","Facção de roupas profissionais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("14.14-2/00","Fabricação de acessórios do vestuário, exceto para segurança e proteção");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("14.21-5/00","Fabricação de meias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("14.22-3/00","Fabricação de artigos do vestuário, produzidos em malharias e tricotagens, exceto meias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("15.10-6/00","Curtimento e outras preparações de couro");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("15.21-1/00","Fabricação de artigos para viagem, bolsas e semelhantes de qualquer material");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("15.29-7/00","Fabricação de artefatos de couro não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("15.31-9/01","Fabricação de calçados de couro");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("15.31-9/02","Acabamento de calçados de couro sob contrato");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("15.32-7/00","Fabricação de tênis de qualquer material");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("15.33-5/00","Fabricação de calçados de material sintético");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("15.39-4/00","Fabricação de calçados de materiais não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("15.40-8/00","Fabricação de partes para calçados, de qualquer material");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("16.10-2/01","Serrarias com desdobramento de madeira");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("16.10-2/02","Serrarias sem desdobramento de madeira");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("16.21-8/00","Fabricação de madeira laminada e de chapas de madeira compensada, prensada e aglomerada");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("16.22-6/01","Fabricação de casas de madeira pré-fabricadas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("16.22-6/02","Fabricação de esquadrias de madeira e de peças de madeira para instalações industriais e omerciais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("16.22-6/99","Fabricação de outros artigos de carpintaria para construção");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("16.23-4/00","Fabricação de artefatos de tanoaria e de embalagens de madeira");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("16.29-3/01","Fabricação de artefatos diversos de madeira, exceto móveis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("16.29-3/02","Fabricação de artefatos diversos de cortiça, bambu, palha, vime e outros materiais rançados, exceto móveis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("17.10-9/00","Fabricação de celulose e outras pastas para a fabricação de papel");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("17.21-4/00","Fabricação de papel");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("17.22-2/00","Fabricação de cartolina e papel-cartão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("17.31-1/00","Fabricação de embalagens de papel");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("17.32-0/00","Fabricação de embalagens de cartolina e papel-cartão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("17.33-8/00","Fabricação de chapas e de embalagens de papelão ondulado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("17.41-9/01","Fabricação de formulários contínuos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("17.41-9/02","Fabricação de produtos de papel, cartolina, papel cartão e papelão ondulado para uso omercial e de escritório, exceto formulário contínuo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("17.42-7/01","Fabricação de fraldas descartáveis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("17.42-7/02","Fabricação de absorventes higiênicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("17.42-7/99","Fabricação de produtos de papel para uso doméstico e higiênico-sanitário não especificados nteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("17.49-4/00","Fabricação de produtos de pastas celulósicas, papel, cartolina, papel-cartão e papelão ndulado não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("18.11-3/01","Impressão de jornais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("18.11-3/02","Impressão de livros, revistas e outras publicações periódicas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("18.12-1/00","Impressão de material de segurança");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("18.13-0/01","Impressão de material para uso publicitário");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("18.13-0/99","Impressão de material para outros usos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("18.21-1/00","Serviços de pré-impressão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("18.22-9/01","Serviços de encadernação e plastificação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("18.22-9/99","Serviços de acabamentos gráficos, exceto encadernação e plastificação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("18.30-0/01","Reprodução de som em qualquer suporte");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("18.30-0/02","Reprodução de vídeo em qualquer suporte");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("18.30-0/03","Reprodução de software em qualquer suporte");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("19.10-1/00","Coquerias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("19.21-7/00","Fabricação de produtos do refino de petróleo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("19.22-5/01","Formulação de combustíveis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("19.22-5/02","Rerrefino de óleos lubrificantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("19.22-5/99","Fabricação de outros produtos derivados do petróleo, exceto produtos do refino");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("19.31-4/00","Fabricação de álcool");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("19.32-2/00","Fabricação de biocombustíveis, exceto álcool");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.11-8/00","Fabricação de cloro e álcalis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.12-6/00","Fabricação de intermediários para fertilizantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.13-4/01","Fabricação de adubos e fertilizantes organo-minerais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.13-4/02","Fabricação de adubos e fertilizantes, exceto organo-minerais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.14-2/00","Fabricação de gases industriais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.19-3/01","Elaboração de combustíveis nucleares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.19-3/99","Fabricação de outros produtos químicos inorgânicos não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.21-5/00","Fabricação de produtos petroquímicos básicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.22-3/00","Fabricação de intermediários para plastificantes, resinas e fibras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.29-1/00","Fabricação de produtos químicos orgânicos não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.31-2/00","Fabricação de resinas termoplásticas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.32-1/00","Fabricação de resinas termofixas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.33-9/00","Fabricação de elastômeros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.40-1/00","Fabricação de fibras artificiais e sintéticas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.51-7/00","Fabricação de defensivos agrícolas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.52-5/00","Fabricação de desinfestantes domissanitários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.61-4/00","Fabricação de sabões e detergentes sintéticos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.62-2/00","Fabricação de produtos de limpeza e polimento");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.63-1/00","Fabricação de cosméticos, produtos de perfumaria e de higiene pessoal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.71-1/00","Fabricação de tintas, vernizes, esmaltes e lacas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.72-0/00","Fabricação de tintas de impressão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.73-8/00","Fabricação de impermeabilizantes, solventes e produtos afins");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.91-6/00","Fabricação de adesivos e selantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.92-4/01","Fabricação de pólvoras, explosivos e detonantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.92-4/02","Fabricação de artigos pirotécnicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.92-4/03","Fabricação de fósforos de segurança");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.93-2/00","Fabricação de aditivos de uso industrial");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.94-1/00","Fabricação de catalisadores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.99-1/01","Fabricação de chapas, filmes, papéis e outros materiais e produtos químicos para fotografia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("20.99-1/99","Fabricação de outros produtos químicos não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("21.10-6/00","Fabricação de produtos farmoquímicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("21.21-1/01","Fabricação de medicamentos alopáticos para uso humano");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("21.21-1/02","Fabricação de medicamentos homeopáticos para uso humano");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("21.21-1/03","Fabricação de medicamentos fitoterápicos para uso humano");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("21.22-0/00","Fabricação de medicamentos para uso veterinário");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("21.23-8/00","Fabricação de preparações farmacêuticas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("22.11-1/00","Fabricação de pneumáticos e de câmaras-de-ar");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("22.12-9/00","Reforma de pneumáticos usados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("22.19-6/00","Fabricação de artefatos de borracha não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("22.21-8/00","Fabricação de laminados planos e tubulares de material plástico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("22.22-6/00","Fabricação de embalagens de material plástico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("22.23-4/00","Fabricação de tubos e acessórios de material plástico para uso na construção");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("22.29-3/01","Fabricação de artefatos de material plástico para uso pessoal e doméstico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("22.29-3/02","Fabricação de artefatos de material plástico para usos industriais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("22.29-3/03","Fabricação de artefatos de material plástico para uso na construção, exceto tubos e cessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("22.29-3/99","Fabricação de artefatos de material plástico para outros usos não especificados nteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.11-7/00","Fabricação de vidro plano e de segurança");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.12-5/00","Fabricação de embalagens de vidro");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.19-2/00","Fabricação de artigos de vidro");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.20-6/00","Fabricação de cimento");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.30-3/01","Fabricação de estruturas pré-moldadas de concreto armado, em série e sob encomenda");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.30-3/02","Fabricação de artefatos de cimento para uso na construção");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.30-3/03","Fabricação de artefatos de fibrocimento para uso na construção");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.30-3/04","Fabricação de casas pré-moldadas de concreto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.30-3/05","Preparação de massa de concreto e argamassa para construção");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.30-3/99","Fabricação de outros artefatos e produtos de concreto, cimento, fibrocimento, gesso e ateriais semelhantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.41-9/00","Fabricação de produtos cerâmicos refratários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.42-7/01","Fabricação de azulejos e pisos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.42-7/02","Fabricação de artefatos de cerâmica e barro cozido para uso na construção, exceto azulejos  pisos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.49-4/01","Fabricação de material sanitário de cerâmica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.49-4/99","Fabricação de produtos cerâmicos não-refratários não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.91-5/01","Britamento de pedras, exceto associado à extração");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.91-5/02","Aparelhamento de pedras para construção, exceto associado à extração");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.91-5/03","Aparelhamento de placas e execução de trabalhos em mármore, granito, ardósia e outras pedras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.92-3/00","Fabricação de cal e gesso");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.99-1/01","Decoração, lapidação, gravação, vitrificação e outros trabalhos em cerâmica, louça, vidro e ristal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.99-1/02","Fabricação de abrasivos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("23.99-1/99","Fabricação de outros produtos de minerais não-metálicos não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.11-3/00","Produção de ferro-gusa");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.12-1/00","Produção de ferroligas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.21-1/00","Produção de semi-acabados de aço");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.22-9/01","Produção de laminados planos de aço ao carbono, revestidos ou não");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.22-9/02","Produção de laminados planos de aços especiais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.23-7/01","Produção de tubos de aço sem costura");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.23-7/02","Produção de laminados longos de aço, exceto tubos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.24-5/01","Produção de arames de aço");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.24-5/02","Produção de relaminados, trefilados e perfilados de aço, exceto arames");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.31-8/00","Produção de tubos de aço com costura");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.39-3/00","Produção de outros tubos de ferro e aço");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.41-5/01","Produção de alumínio e suas ligas em formas primárias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.41-5/02","Produção de laminados de alumínio");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.42-3/00","Metalurgia dos metais preciosos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.43-1/00","Metalurgia do cobre");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.49-1/01","Produção de zinco em formas primárias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.49-1/02","Produção de laminados de zinco");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.49-1/03","Fabricação de ânodos para galvanoplastia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.49-1/99","Metalurgia de outros metais não-ferrosos e suas ligas não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.51-2/00","Fundição de ferro e aço");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("24.52-1/00","Fundição de metais não-ferrosos e suas ligas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.11-0/00","Fabricação de estruturas metálicas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.12-8/00","Fabricação de esquadrias de metal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.13-6/00","Fabricação de obras de caldeiraria pesada");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.21-7/00","Fabricação de tanques, reservatórios metálicos e caldeiras para aquecimento central");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.22-5/00","Fabricação de caldeiras geradoras de vapor, exceto para aquecimento central e para veículos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.31-4/01","Produção de forjados de aço");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.31-4/02","Produção de forjados de metais não-ferrosos e suas ligas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.32-2/01","Produção de artefatos estampados de metal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.32-2/02","Metalurgia do pó");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.39-0/01","Serviços de usinagem, tornearia e solda");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.39-0/02","Serviços de tratamento e revestimento em metais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.41-1/00","Fabricação de artigos de cutelaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.42-0/00","Fabricação de artigos de serralheria, exceto esquadrias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.43-8/00","Fabricação de ferramentas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.50-1/01","Fabricação de equipamento bélico pesado, exceto veículos militares de combate");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.50-1/02","Fabricação de armas de fogo e munições");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.91-8/00","Fabricação de embalagens metálicas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.92-6/01","Fabricação de produtos de trefilados de metal padronizados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.92-6/02","Fabricação de produtos de trefilados de metal, exceto padronizados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.93-4/00","Fabricação de artigos de metal para uso doméstico e pessoal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.99-3/01","Serviços de confecção de armações metálicas para a construção");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.99-3/02","Serviços de corte e dobra de metais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("25.99-3/99","Fabricação de outros produtos de metal não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("26.10-8/00","Fabricação de componentes eletrônicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("26.21-3/00","Fabricação de equipamentos de informática");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("26.22-1/00","Fabricação de periféricos para equipamentos de informática");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("26.31-1/00","Fabricação de equipamentos transmissores de comunicação, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("26.32-9/00","Fabricação de aparelhos telefônicos e de outros equipamentos de comunicação, peças e cessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("26.40-0/00","Fabricação de aparelhos de recepção, reprodução, gravação e amplificação de áudio e vídeo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("26.51-5/00","Fabricação de aparelhos e equipamentos de medida, teste e controle");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("26.52-3/00","Fabricação de cronômetros e relógios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("26.60-4/00","Fabricação de aparelhos eletromédicos e eletroterapêuticos e equipamentos de irradiação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("26.70-1/01","Fabricação de equipamentos e instrumentos ópticos, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("26.70-1/02","Fabricação de aparelhos fotográficos e cinematográficos, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("26.80-9/00","Fabricação de mídias virgens, magnéticas e ópticas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.10-4/01","Fabricação de geradores de corrente contínua e alternada, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.10-4/02","Fabricação de transformadores, indutores, conversores, sincronizadores e semelhantes, peças  acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.10-4/03","Fabricação de motores elétricos, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.21-0/00","Fabricação de pilhas, baterias e acumuladores elétricos, exceto para veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.22-8/01","Fabricação de baterias e acumuladores para veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.22-8/02","Recondicionamento de baterias e acumuladores para veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.31-7/00","Fabricação de aparelhos e equipamentos para distribuição e controle de energia elétrica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.32-5/00","Fabricação de material elétrico para instalações em circuito de consumo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.33-3/00","Fabricação de fios, cabos e condutores elétricos isolados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.40-6/01","Fabricação de lâmpadas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.40-6/02","Fabricação de luminárias e outros equipamentos de iluminação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.51-1/00","Fabricação de fogões, refrigeradores e máquinas de lavar e secar para uso doméstico, peças  acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.59-7/01","Fabricação de aparelhos elétricos de uso pessoal, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.59-7/99","Fabricação de outros aparelhos eletrodomésticos não especificados anteriormente, peças e cessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.90-2/01","Fabricação de eletrodos, contatos e outros artigos de carvão e grafita para uso elétrico, letroímãs e isoladores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.90-2/02","Fabricação de equipamentos para sinalização e alarme");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("27.90-2/99","Fabricação de outros equipamentos e aparelhos elétricos não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.11-9/00","Fabricação de motores e turbinas, peças e acessórios, exceto para aviões e veículos odoviários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.12-7/00","Fabricação de equipamentos hidráulicos e pneumáticos, peças e acessórios, exceto válvulas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.13-5/00","Fabricação de válvulas, registros e dispositivos semelhantes, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.14-3/01","Fabricação de compressores para uso industrial, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.14-3/02","Fabricação de compressores para uso não industrial, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.15-1/01","Fabricação de rolamentos para fins industriais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.15-1/02","Fabricação de equipamentos de transmissão para fins industriais, exceto rolamentos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.21-6/01","Fabricação de fornos industriais, aparelhos e equipamentos não-elétricos para instalações érmicas, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.21-6/02","Fabricação de estufas e fornos elétricos para fins industriais, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.22-4/01","Fabricação de máquinas, equipamentos e aparelhos para transporte e elevação de pessoas, eças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.22-4/02","Fabricação de máquinas, equipamentos e aparelhos para transporte e elevação de cargas, eças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.23-2/00","Fabricação de máquinas e aparelhos de refrigeração e ventilação para uso industrial e omercial, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.24-1/01","Fabricação de aparelhos e equipamentos de ar condicionado para uso industrial");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.24-1/02","Fabricação de aparelhos e equipamentos de ar condicionado para uso não-industrial");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.25-9/00","Fabricação de máquinas e equipamentos para saneamento básico e ambiental, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.29-1/01","Fabricação de máquinas de escrever, calcular e outros equipamentos não-eletrônicos para scritório, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.29-1/99","Fabricação de outras máquinas e equipamentos de uso geral não especificados anteriormente, eças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.31-3/00","Fabricação de tratores agrícolas, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.32-1/00","Fabricação de equipamentos para irrigação agrícola, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.33-0/00","Fabricação de máquinas e equipamentos para a agricultura e pecuária, peças e acessórios, xceto para irrigação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.40-2/00","Fabricação de máquinas-ferramenta, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.51-8/00","Fabricação de máquinas e equipamentos para a prospecção e extração de petróleo, peças e cessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.52-6/00","Fabricação de outras máquinas e equipamentos para uso na extração mineral, peças e cessórios, exceto na extração de petróleo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.53-4/00","Fabricação de tratores, peças e acessórios, exceto agrícolas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.54-2/00","Fabricação de máquinas e equipamentos para terraplenagem, pavimentação e construção, peças  acessórios, exceto tratores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.61-5/00","Fabricação de máquinas para a indústria metalúrgica, peças e acessórios, exceto áquinas-ferramenta");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.62-3/00","Fabricação de máquinas e equipamentos para as indústrias de alimentos, bebidas e fumo, eças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.63-1/00","Fabricação de máquinas e equipamentos para a indústria têxtil, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.64-0/00","Fabricação de máquinas e equipamentos para as indústrias do vestuário, do couro e de alçados, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.65-8/00","Fabricação de máquinas e equipamentos para as indústrias de celulose, papel e papelão e rtefatos, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.66-6/00","Fabricação de máquinas e equipamentos para a indústria do plástico, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("28.69-1/00","Fabricação de máquinas e equipamentos para uso industrial específico não especificados nteriormente, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.10-7/01","Fabricação de automóveis, camionetas e utilitários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.10-7/02","Fabricação de chassis com motor para automóveis, camionetas e utilitários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.10-7/03","Fabricação de motores para automóveis, camionetas e utilitários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.20-4/01","Fabricação de caminhões e ônibus");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.20-4/02","Fabricação de motores para caminhões e ônibus");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.30-1/01","Fabricação de cabines, carrocerias e reboques para caminhões");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.30-1/02","Fabricação de carrocerias para ônibus");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.30-1/03","Fabricação de cabines, carrocerias e reboques para outros veículos automotores, exceto aminhões e ônibus");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.41-7/00","Fabricação de peças e acessórios para o sistema motor de veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.42-5/00","Fabricação de peças e acessórios para os sistemas de marcha e transmissão de veículos utomotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.43-3/00","Fabricação de peças e acessórios para o sistema de freios de veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.44-1/00","Fabricação de peças e acessórios para o sistema de direção e suspensão de veículos utomotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.45-0/00","Fabricação de material elétrico e eletrônico para veículos automotores, exceto baterias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.49-2/01","Fabricação de bancos e estofados para veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.49-2/99","Fabricação de outras peças e acessórios para veículos automotores não especificadas nteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("29.50-6/00","Recondicionamento e recuperação de motores para veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("30.11-3/01","Construção de embarcações de grande porte");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("30.11-3/02","Construção de embarcações para uso comercial e para usos especiais, exceto de grande porte");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("30.12-1/00","Construção de embarcações para esporte e lazer");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("30.31-8/00","Fabricação de locomotivas, vagões e outros materiais rodantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("30.32-6/00","Fabricação de peças e acessórios para veículos ferroviários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("30.41-5/00","Fabricação de aeronaves");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("30.42-3/00","Fabricação de turbinas, motores e outros componentes e peças para aeronaves");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("30.50-4/00","Fabricação de veículos militares de combate");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("30.91-1/01","Fabricação de motocicletas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("30.91-1/02","Fabricação de peças e acessórios para motocicletas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("30.92-0/00","Fabricação de bicicletas e triciclos não-motorizados, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("30.99-7/00","Fabricação de equipamentos de transporte não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("31.01-2/00","Fabricação de móveis com predominância de madeira");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("31.02-1/00","Fabricação de móveis com predominância de metal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("31.03-9/00","Fabricação de móveis de outros materiais, exceto madeira e metal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("31.04-7/00","Fabricação de colchões");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.11-6/01","Lapidação de gemas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.11-6/02","Fabricação de artefatos de joalheria e ourivesaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.11-6/03","Cunhagem de moedas e medalhas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.12-4/00","Fabricação de bijuterias e artefatos semelhantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.20-5/00","Fabricação de instrumentos musicais, peças e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.30-2/00","Fabricação de artefatos para pesca e esporte");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.40-0/01","Fabricação de jogos eletrônicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.40-0/02","Fabricação de mesas de bilhar, de sinuca e acessórios não associada à locação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.40-0/03","Fabricação de mesas de bilhar, de sinuca e acessórios associada à locação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.40-0/99","Fabricação de outros brinquedos e jogos recreativos não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.50-7/01","Fabricação de instrumentos não-eletrônicos e utensílios para uso médico, cirúrgico, dontológico e de laboratório");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.50-7/02","Fabricação de mobiliário para uso médico, cirúrgico, odontológico e de laboratório");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.50-7/03","Fabricação de aparelhos e utensílios para correção de defeitos físicos e aparelhos rtopédicos em geral sob encomenda");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.50-7/04","Fabricação de aparelhos e utensílios para correção de defeitos físicos e aparelhos rtopédicos em geral, exceto sob encomenda");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.50-7/05","Fabricação de materiais para medicina e odontologia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.50-7/06","Serviços de prótese dentária");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.50-7/07","Fabricação de artigos ópticos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.50-7/09","Serviço de laboratório óptico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.91-4/00","Fabricação de escovas, pincéis e vassouras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.92-2/01","Fabricação de roupas de proteção e segurança e resistentes a fogo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.92-2/02","Fabricação de equipamentos e acessórios para segurança pessoal e profissional");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.99-0/01","Fabricação de guarda-chuvas e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.99-0/02","Fabricação de canetas, lápis e outros artigos para escritório");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.99-0/03","Fabricação de letras, letreiros e placas de qualquer material, exceto luminosos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.99-0/04","Fabricação de painéis e letreiros luminosos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.99-0/05","Fabricação de aviamentos para costura");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.99-0/06","Fabricação de velas, inclusive decorativas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("32.99-0/99","Fabricação de produtos diversos não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.11-2/00","Manutenção e reparação de tanques, reservatórios metálicos e caldeiras, exceto para veículos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.12-1/02","Manutenção e reparação de aparelhos e instrumentos de medida, teste e controle");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.12-1/03","Manutenção e reparação de aparelhos eletromédicos e eletroterapêuticos e equipamentos de rradiação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.12-1/04","Manutenção e reparação de equipamentos e instrumentos ópticos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.13-9/01","Manutenção e reparação de geradores, transformadores e motores elétricos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.13-9/02","Manutenção e reparação de baterias e acumuladores elétricos, exceto para veículos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.13-9/99","Manutenção e reparação de máquinas, aparelhos e materiais elétricos não especificados nteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/01","Manutenção e reparação de máquinas motrizes não-elétricas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/02","Manutenção e reparação de equipamentos hidráulicos e pneumáticos, exceto válvulas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/03","Manutenção e reparação de válvulas industriais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/04","Manutenção e reparação de compressores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/05","Manutenção e reparação de equipamentos de transmissão para fins industriais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/06","Manutenção e reparação de máquinas, aparelhos e equipamentos para instalações térmicas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/07","Manutenção e reparação de máquinas e aparelhos de refrigeração e ventilação para uso ndustrial e comercial");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/08","Manutenção e reparação de máquinas, equipamentos e aparelhos para transporte e elevação de argas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/09","Manutenção e reparação de máquinas de escrever, calcular e de outros equipamentos ão-eletrônicos para escritório");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/10","Manutenção e reparação de máquinas e equipamentos para uso geral não especificados nteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/11","Manutenção e reparação de máquinas e equipamentos para agricultura e pecuária");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/12","Manutenção e reparação de tratores agrícolas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/13","Manutenção e reparação de máquinas-ferramenta");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/14","Manutenção e reparação de máquinas e equipamentos para a prospecção e extração de petróleo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/15","Manutenção e reparação de máquinas e equipamentos para uso na extração mineral, exceto na xtração de petróleo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/16","Manutenção e reparação de tratores, exceto agrícolas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/17","Manutenção e reparação de máquinas e equipamentos de terraplenagem, pavimentação e onstrução, exceto tratores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/18","Manutenção e reparação de máquinas para a indústria metalúrgica, exceto máquinas-ferramenta");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/19","Manutenção e reparação de máquinas e equipamentos para as indústrias de alimentos, bebidas  fumo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/20","Manutenção e reparação de máquinas e equipamentos para a indústria têxtil, do vestuário, do ouro e calçados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/21","Manutenção e reparação de máquinas e aparelhos para a indústria de celulose, papel e apelão e artefatos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/22","Manutenção e reparação de máquinas e aparelhos para a indústria do plástico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.14-7/99","Manutenção e reparação de outras máquinas e equipamentos para usos industriais não specificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.15-5/00","Manutenção e reparação de veículos ferroviários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.16-3/01","Manutenção e reparação de aeronaves, exceto a manutenção na pista");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.16-3/02","Manutenção de aeronaves na pista");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.17-1/01","Manutenção e reparação de embarcações e estruturas flutuantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.17-1/02","Manutenção e reparação de embarcações para esporte e lazer");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.19-8/00","Manutenção e reparação de equipamentos e produtos não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.21-0/00","Instalação de máquinas e equipamentos industriais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.29-5/01","Serviços de montagem de móveis de qualquer material");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("33.29-5/99","Instalação de outros equipamentos não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("35.11-5/01","Geração de energia elétrica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("35.11-5/02","Atividades de coordenação e controle de operação de geração e transmissão de energia létrica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("35.12-3/00","Transmissão de energia elétrica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("35.13-1/00","Comércio atacadista de energia elétrica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("35.14-0/00","Distribuição de energia elétrica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("35.20-4/01","Produção de gás; processamento de gás natura");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("35.20-4/02","Distribuição de combustíveis gasosos por redes urbanas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("35.30-1/00","Produção e distribuição de vapor, água quente e ar condicionado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("36.00-6/01","Captação, tratamento e distribuição de água");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("36.00-6/02","Distribuição de água por caminhões");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("37.01-1/00","Gestão de redes de esgoto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("37.02-9/00","Atividades relacionadas a esgoto, exceto a gestão de redes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("38.11-4/00","Coleta de resíduos não-perigosos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("38.12-2/00","Coleta de resíduos perigosos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("38.21-1/00","Tratamento e disposição de resíduos não-perigosos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("38.22-0/00","Tratamento e disposição de resíduos perigosos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("38.31-9/01","Recuperação de sucatas de alumínio");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("38.31-9/99","Recuperação de materiais metálicos, exceto alumínio");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("38.32-7/00","Recuperação de materiais plásticos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("38.39-4/01","Usinas de compostagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("38.39-4/99","Recuperação de materiais não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("39.00-5/00","Descontaminação e outros serviços de gestão de resíduos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("41.10-7/00","Incorporação de empreendimentos imobiliários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("41.20-4/00","Construção de edifícios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.11-1/01","Construção de rodovias e ferrovias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.11-1/02","Pintura para sinalização em pistas rodoviárias e aeroportos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.12-0/00","Construção de obras de arte especiais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.13-8/00","Obras de urbanização - ruas, praças e calçadas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.21-9/01","Construção de barragens e represas para geração de energia elétrica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.21-9/02","Construção de estações e redes de distribuição de energia elétrica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.21-9/03","Manutenção de redes de distribuição de energia elétrica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.21-9/04","Construção de estações e redes de telecomunicações");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.21-9/05","Manutenção de estações e redes de telecomunicações");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.22-7/01","Construção de redes de abastecimento de água, coleta de esgoto e construções correlatas, xceto obras de irrigação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.22-7/02","Obras de irrigação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.23-5/00","Construção de redes de transportes por dutos, exceto para água e esgoto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.91-0/00","Obras portuárias, marítimas e fluviais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.92-8/01","Montagem de estruturas metálicas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.92-8/02","Obras de montagem industrial");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.99-5/01","Construção de instalações esportivas e recreativas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("42.99-5/99","Outras obras de engenharia civil não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.11-8/01","Demolição de edifícios e outras estruturas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.11-8/02","Preparação de canteiro e limpeza de terreno");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.12-6/00"," Perfurações e sondagens");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.13-4/00","Obras de terraplenagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.19-3/00","Serviços de preparação do terreno não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.21-5/00"," Instalação e manutenção elétrica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.22-3/01","Instalações hidráulicas, sanitárias e de gás");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.22-3/02","Instalação e manutenção de sistemas centrais de ar condicionado, de ventilação e efrigeração");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.22-3/03","Instalações de sistema de prevenção contra incêndio");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.29-1/01","Instalação de painéis publicitários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.29-1/02","Instalação de equipamentos para orientação à navegação marítima fluvial e lacustre");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.29-1/03","Instalação, manutenção e reparação de elevadores, escadas e esteiras rolantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.29-1/04","Montagem e instalação de sistemas e equipamentos de iluminação e sinalização em vias úblicas, portos e aeroportos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.29-1/05","Tratamentos térmicos, acústicos ou de vibração");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.29-1/99","Outras obras de instalações em construções não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.30-4/01","Impermeabilização em obras de engenharia civil");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.30-4/02","Instalação de portas, janelas, tetos, divisórias e armários embutidos de qualquer material");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.30-4/03","Obras de acabamento em gesso e estuque");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.30-4/04","Serviços de pintura de edifícios em geral");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.30-4/05","Aplicação de revestimentos e de resinas em interiores e exteriores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.30-4/99","Outras obras de acabamento da construção");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.91-6/00","Obras de fundações");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.99-1/01","Administração de obras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.99-1/02","Montagem e desmontagem de andaimes e outras estruturas temporárias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.99-1/03","Obras de alvenaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.99-1/04","Serviços de operação e fornecimento de equipamentos para transporte e elevação de cargas e essoas para uso em obras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.99-1/05","Perfuração e construção de poços de água");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("43.99-1/99","Serviços especializados para construção não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.11-1/01","Comércio a varejo de automóveis, camionetas e utilitários novos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.11-1/02","Comércio a varejo de automóveis, camionetas e utilitários usados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.11-1/03","Comércio por atacado de automóveis, camionetas e utilitários novos e usados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.11-1/04","Comércio por atacado de caminhões novos e usados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.11-1/05","Comércio por atacado de reboques e semi-reboques novos e usados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.11-1/06","Comércio por atacado de ônibus e microônibus novos e usados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.12-9/01","Representantes comerciais e agentes do comércio de veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.12-9/02","Comércio sob consignação de veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.20-0/01","Serviços de manutenção e reparação mecânica de veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.20-0/02","Serviços de lanternagem ou funilaria e pintura de veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.20-0/03","Serviços de manutenção e reparação elétrica de veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.20-0/04","Serviços de alinhamento e balanceamento de veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.20-0/05","Serviços de lavagem, lubrificação e polimento de veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.20-0/06","Serviços de borracharia para veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.20-0/07","Serviços de instalação, manutenção e reparação de acessórios para veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.20-0/08","Serviços de capotaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.30-7/01","Comércio por atacado de peças e acessórios novos para veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.30-7/02","Comércio por atacado de pneumáticos e câmaras-de-ar");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.30-7/03","Comércio a varejo de peças e acessórios novos para veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.30-7/04","Comércio a varejo de peças e acessórios usados para veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.30-7/05","Comércio a varejo de pneumáticos e câmaras-de-ar");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.30-7/06","Representantes comerciais e agentes do comércio de peças e acessórios novos e usados para eículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.41-2/01","Comércio por atacado de motocicletas e motonetas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.41-2/02","Comércio por atacado de peças e acessórios para motocicletas e motonetas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.41-2/03","Comércio a varejo de motocicletas e motonetas novas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.41-2/04","Comércio a varejo de motocicletas e motonetas usadas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.41-2/05","Comércio a varejo de peças e acessórios para motocicletas e motonetas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.42-1/01","Representantes comerciais e agentes do comércio de motocicletas e motonetas, peças e cessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.42-1/02","Comércio sob consignação de motocicletas e motonetas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("45.43-9/00","Manutenção e reparação de motocicletas e motonetas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.11-7/00","Representantes comerciais e agentes do comércio de matérias-primas agrícolas e animais vivos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.12-5/00","Representantes comerciais e agentes do comércio de combustíveis, minerais, produtos iderúrgicos e químicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.13-3/00","Representantes comerciais e agentes do comércio de madeira, material de construção e erragens");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.14-1/00","Representantes comerciais e agentes do comércio de máquinas, equipamentos, embarcações e eronaves");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.15-0/00","Representantes comerciais e agentes do comércio de eletrodomésticos, móveis e artigos de so doméstico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.16-8/00","Representantes comerciais e agentes do comércio de têxteis, vestuário, calçados e artigos e viagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.17-6/00","Representantes comerciais e agentes do comércio de produtos alimentícios, bebidas e fumo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.18-4/01","Representantes comerciais e agentes do comércio de medicamentos, cosméticos e produtos de erfumaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.18-4/02","Representantes comerciais e agentes do comércio de instrumentos e materiais donto-médico-hospitalares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.18-4/03","Representantes comerciais e agentes do comércio de jornais, revistas e outras publicações");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.18-4/99","Outros representantes comerciais e agentes do comércio especializado em produtos não specificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.19-2/00","Representantes comerciais e agentes do comércio de mercadorias em geral não especializado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.21-4/00","Comércio atacadista de café em grão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.22-2/00","Comércio atacadista de soja");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.23-1/01","Comércio atacadista de animais vivos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.23-1/02","Comércio atacadista de couros, lãs, peles e outros subprodutos não-comestíveis de origem nimal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.23-1/03","Comércio atacadista de algodão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.23-1/04","Comércio atacadista de fumo em folha não beneficiado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.23-1/05","Comércio atacadista de cacau");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.23-1/06","Comércio atacadista de sementes, flores, plantas e gramas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.23-1/07","Comércio atacadista de sisal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.23-1/08","Comércio atacadista de matérias-primas agrícolas com atividade de fracionamento e condicionamento associada");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.23-1/09","Comércio atacadista de alimentos para animais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.23-1/99","Comércio atacadista de matérias-primas agrícolas não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.31-1/00","Comércio atacadista de leite e laticínios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.32-0/01"," Comércio atacadista de cereais e leguminosas beneficiados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.32-0/02","Comércio atacadista de farinhas, amidos e féculas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.32-0/03","Comércio atacadista de cereais e leguminosas beneficiados, farinhas, amidos e féculas, com tividade de fracionamento e acondicionamento associada");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.33-8/01","Comércio atacadista de frutas, verduras, raízes, tubérculos, hortaliças e legumes frescos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.33-8/02","Comércio atacadista de aves vivas e ovos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.33-8/03","Comércio atacadista de coelhos e outros pequenos animais vivos para alimentação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.34-6/01","Comércio atacadista de carnes bovinas e suínas e derivados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.34-6/02","Comércio atacadista de aves abatidas e derivados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.34-6/03","Comércio atacadista de pescados e frutos do mar");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.34-6/99","Comércio atacadista de carnes e derivados de outros animais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.35-4/01","Comércio atacadista de água mineral");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.35-4/02","Comércio atacadista de cerveja, chope e refrigerante");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.35-4/03","Comércio atacadista de bebidas com atividade de fracionamento e acondicionamento associada");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.35-4/99","Comércio atacadista de bebidas não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.36-2/01","Comércio atacadista de fumo beneficiado");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.36-2/02","Comércio atacadista de cigarros, cigarrilhas e charutos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.37-1/01","Comércio atacadista de café torrado, moído e solúvel");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.37-1/02","Comércio atacadista de açúcar");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.37-1/03","Comércio atacadista de óleos e gorduras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.37-1/04","Comércio atacadista de pães, bolos, biscoitos e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.37-1/05","Comércio atacadista de massas alimentícias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.37-1/06","Comércio atacadista de sorvetes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.37-1/07","Comércio atacadista de chocolates, confeitos, balas, bombons e semelhantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.37-1/99","Comércio atacadista especializado em outros produtos alimentícios não especificados nteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.39-7/01","Comércio atacadista de produtos alimentícios em geral");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.39-7/02","Comércio atacadista de produtos alimentícios em geral, com atividade de fracionamento e condicionamento associada");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.41-9/01","Comércio atacadista de tecidos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.41-9/02","Comércio atacadista de artigos de cama, mesa e banho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.41-9/03","Comércio atacadista de artigos de armarinho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.42-7/01","Comércio atacadista de artigos do vestuário e acessórios, exceto profissionais e de egurança");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.42-7/02","Comércio atacadista de roupas e acessórios para uso profissional e de segurança do trabalho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.43-5/01","Comércio atacadista de calçados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.43-5/02","Comércio atacadista de bolsas, malas e artigos de viagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.44-3/01","Comércio atacadista de medicamentos e drogas de uso humano");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.44-3/02","Comércio atacadista de medicamentos e drogas de uso veterinário");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.45-1/01","Comércio atacadista de instrumentos e materiais para uso médico, cirúrgico, hospitalar e de aboratórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.45-1/02","Comércio atacadista de próteses e artigos de ortopedia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.45-1/03","Comércio atacadista de produtos odontológicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.46-0/01","Comércio atacadista de cosméticos e produtos de perfumaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.46-0/02","Comércio atacadista de produtos de higiene pessoal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.47-8/01","Comércio atacadista de artigos de escritório e de papelaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.47-8/02","Comércio atacadista de livros, jornais e outras publicações");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.49-4/01","Comércio atacadista de equipamentos elétricos de uso pessoal e doméstico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.49-4/02","Comércio atacadista de aparelhos eletrônicos de uso pessoal e doméstico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.49-4/03","Comércio atacadista de bicicletas, triciclos e outros veículos recreativos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.49-4/04","Comércio atacadista de móveis e artigos de colchoaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.49-4/05","Comércio atacadista de artigos de tapeçaria; persianas e cortina");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.49-4/06","Comércio atacadista de lustres, luminárias e abajures");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.49-4/07","Comércio atacadista de filmes, CDs, DVDs, fitas e discos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.49-4/08","Comércio atacadista de produtos de higiene, limpeza e conservação domiciliar");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.49-4/09","Comércio atacadista de produtos de higiene, limpeza e conservação domiciliar, com atividade e fracionamento e acondicionamento associada");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.49-4/10","Comércio atacadista de jóias, relógios e bijuterias, inclusive pedras preciosas e emipreciosas lapidadas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.49-4/99","Comércio atacadista de outros equipamentos e artigos de uso pessoal e doméstico não specificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.51-6/01","Comércio atacadista de equipamentos de informática");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.51-6/02","Comércio atacadista de suprimentos para informática");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.52-4/00","Comércio atacadista de componentes eletrônicos e equipamentos de telefonia e comunicação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.61-3/00","Comércio atacadista de máquinas, aparelhos e equipamentos para uso agropecuário; partes e eça");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.62-1/00","Comércio atacadista de máquinas, equipamentos para terraplenagem, mineração e construção; artes e peça");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.63-0/00","Comércio atacadista de máquinas e equipamentos para uso industrial; partes e peça");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.64-8/00","Comércio atacadista de máquinas, aparelhos e equipamentos para uso donto-médico-hospitalar; partes e peça");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.65-6/00","Comércio atacadista de máquinas e equipamentos para uso comercial; partes e peça");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.69-9/01","Comércio atacadista de bombas e compressores; partes e peça");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.69-9/99","Comércio atacadista de outras máquinas e equipamentos não especificados anteriormente; artes e peça");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.71-1/00","Comércio atacadista de madeira e produtos derivados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.72-9/00","Comércio atacadista de ferragens e ferramentas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.73-7/00","Comércio atacadista de material elétrico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.74-5/00","Comércio atacadista de cimento");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.79-6/01","Comércio atacadista de tintas, vernizes e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.79-6/02","Comércio atacadista de mármores e granitos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.79-6/03","Comércio atacadista de vidros, espelhos, vitrais e molduras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.79-6/04","Comércio atacadista especializado de materiais de construção não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.79-6/99","Comércio atacadista de materiais de construção em geral");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.81-8/01","Comércio atacadista de álcool carburante, biodiesel, gasolina e demais derivados de etróleo, exceto lubrificantes, não realizado por transportador retalhista (T.R.R.)");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.81-8/02","Comércio atacadista de combustíveis realizado por transportador retalhista (T.R.R.)");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.81-8/03","Comércio atacadista de combustíveis de origem vegetal, exceto álcool carburante");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.81-8/04","Comércio atacadista de combustíveis de origem mineral em bruto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.81-8/05","Comércio atacadista de lubrificantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.82-6/00","Comércio atacadista de gás liqüefeito de petróleo (GLP)");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.83-4/00","Comércio atacadista de defensivos agrícolas, adubos, fertilizantes e corretivos do solo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.84-2/01","Comércio atacadista de resinas e elastômeros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.84-2/02","Comércio atacadista de solventes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.84-2/99","Comércio atacadista de outros produtos químicos e petroquímicos não especificados nteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.85-1/00","Comércio atacadista de produtos siderúrgicos e metalúrgicos, exceto para construção");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.86-9/01","Comércio atacadista de papel e papelão em bruto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.86-9/02","Comércio atacadista de embalagens");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.87-7/01","Comércio atacadista de resíduos de papel e papelão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.87-7/02","Comércio atacadista de resíduos e sucatas não-metálicos, exceto de papel e papelão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.87-7/03","Comércio atacadista de resíduos e sucatas metálicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.89-3/01","Comércio atacadista de produtos da extração mineral, exceto combustíveis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.89-3/02","Comércio atacadista de fios e fibras têxteis beneficiados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.89-3/99","Comércio atacadista especializado em outros produtos intermediário não especificados nteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.91-5/00","Comércio atacadista de mercadorias em geral, com predominância de produtos alimentícios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.92-3/00","Comércio atacadista de mercadorias em geral, com predominância de insumos agropecuários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("46.93-1/00","Comércio atacadista de mercadorias em geral, sem predominância de alimentos ou de insumos gropecuários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.11-3/01","Comércio varejista de mercadorias em geral, com predominância de produtos alimentícios - ipermercados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.11-3/02","Comércio varejista de mercadorias em geral, com predominância de produtos alimentícios - upermercados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.12-1/00","Comércio varejista de mercadorias em geral, com predominância de produtos alimentícios - inimercados, mercearias e armazéns");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.13-0/01","Lojas de departamentos ou magazines");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.13-0/02","Lojas de variedades, exceto lojas de departamentos ou magazines");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.13-0/03"," Lojas duty free de aeroportos internacionais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.21-1/02","Padaria e confeitaria com predominância de revenda");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.21-1/03","Comércio varejista de laticínios e frios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.21-1/04","Comércio varejista de doces, balas, bombons e semelhantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.22-9/01","Comércio varejista de carnes - açougues");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.22-9/02","Peixaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.23-7/00","Comércio varejista de bebidas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.24-5/00","Comércio varejista de hortifrutigranjeiros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.29-6/01","Tabacaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.29-6/02","Comércio varejista de mercadorias em lojas de conveniência");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.29-6/99","Comércio varejista de produtos alimentícios em geral ou especializado em produtos limentícios não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.31-8/00","Comércio varejista de combustíveis para veículos automotores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.32-6/00","Comércio varejista de lubrificantes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.41-5/00","Comércio varejista de tintas e materiais para pintura");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.42-3/00","Comércio varejista de material elétrico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.43-1/00","Comércio varejista de vidros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.44-0/01","Comércio varejista de ferragens e ferramentas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.44-0/02","Comércio varejista de madeira e artefatos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.44-0/03","Comércio varejista de materiais hidráulicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.44-0/04","Comércio varejista de cal, areia, pedra britada, tijolos e telhas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.44-0/05","Comércio varejista de materiais de construção não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.44-0/06","Comércio varejista de pedras para revestimento");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.44-0/99","Comércio varejista de materiais de construção em geral");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.51-2/01","Comércio varejista especializado de equipamentos e suprimentos de informática");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.51-2/02","Recarga de cartuchos para equipamentos de informática");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.52-1/00","Comércio varejista especializado de equipamentos de telefonia e comunicação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.53-9/00","Comércio varejista especializado de eletrodomésticos e equipamentos de áudio e vídeo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.54-7/01","Comércio varejista de móveis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.54-7/02","Comércio varejista de artigos de colchoaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.54-7/03","Comércio varejista de artigos de iluminação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.55-5/01","Comércio varejista de tecidos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.55-5/02","Comercio varejista de artigos de armarinho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.55-5/03","Comercio varejista de artigos de cama, mesa e banho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.56-3/00","Comércio varejista especializado de instrumentos musicais e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.57-1/00","Comércio varejista especializado de peças e acessórios para aparelhos eletroeletrônicos ara uso doméstico, exceto informática e comunicação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.59-8/01","Comércio varejista de artigos de tapeçaria, cortinas e persianas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.59-8/99","Comércio varejista de outros artigos de uso doméstico não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.61-0/01","Comércio varejista de livros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.61-0/02","Comércio varejista de jornais e revistas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.61-0/03","Comércio varejista de artigos de papelaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.62-8/00","Comércio varejista de discos, CDs, DVDs e fitas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.63-6/01","Comércio varejista de brinquedos e artigos recreativos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.63-6/02","Comércio varejista de artigos esportivos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.63-6/03","Comércio varejista de bicicletas e triciclos; peças e acessório");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.63-6/04","Comércio varejista de artigos de caça, pesca e camping");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.63-6/05","Comércio varejista de embarcações e outros veículos recreativos; peças e acessório");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.71-7/01","Comércio varejista de produtos farmacêuticos, sem manipulação de fórmulas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.71-7/02","Comércio varejista de produtos farmacêuticos, com manipulação de fórmulas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.71-7/03","Comércio varejista de produtos farmacêuticos homeopáticos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.71-7/04","Comércio varejista de medicamentos veterinários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.72-5/00","Comércio varejista de cosméticos, produtos de perfumaria e de higiene pessoal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.73-3/00","Comércio varejista de artigos médicos e ortopédicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.74-1/00","Comércio varejista de artigos de óptica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.81-4/00","Comércio varejista de artigos do vestuário e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.82-2/01","Comércio varejista de calçados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.82-2/02","Comércio varejista de artigos de viagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.83-1/01","Comércio varejista de artigos de joalheria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.83-1/02","Comércio varejista de artigos de relojoaria");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.84-9/00","Comércio varejista de gás liqüefeito de petróleo (GLP)");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.85-7/01","Comércio varejista de antigüidades");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.85-7/99","Comércio varejista de outros artigos usados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.89-0/01","Comércio varejista de suvenires, bijuterias e artesanatos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.89-0/02","Comércio varejista de plantas e flores naturais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.89-0/03","Comércio varejista de objetos de arte");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.89-0/04","Comércio varejista de animais vivos e de artigos e alimentos para animais de estimação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.89-0/05","Comércio varejista de produtos saneantes domissanitários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.89-0/06","Comércio varejista de fogos de artifício e artigos pirotécnicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.89-0/07","Comércio varejista de equipamentos para escritório");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.89-0/08","Comércio varejista de artigos fotográficos e para filmagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.89-0/09","Comércio varejista de armas e munições");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("47.89-0/99","Comércio varejista de outros produtos não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.11-6/00","Transporte ferroviário de carga");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.12-4/01","Transporte ferroviário de passageiros intermunicipal e interestadual");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.12-4/02","Transporte ferroviário de passageiros municipal e em região metropolitana");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.12-4/03","Transporte metroviário");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.21-3/01","Transporte rodoviário coletivo de passageiros, com itinerário fixo, municipal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.21-3/02","Transporte rodoviário coletivo de passageiros, com itinerário fixo, intermunicipal em egião metropolitana");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.22-1/01","Transporte rodoviário coletivo de passageiros, com itinerário fixo, intermunicipal, exceto m região metropolitana");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.22-1/02","Transporte rodoviário coletivo de passageiros, com itinerário fixo, interestadual");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.22-1/03","Transporte rodoviário coletivo de passageiros, com itinerário fixo, internacional");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.23-0/01","Serviço de táxi");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.23-0/02","Serviço de transporte de passageiros - locação de automóveis com motorista");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.24-8/00","Transporte escolar");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.29-9/01","Transporte rodoviário coletivo de passageiros, sob regime de fretamento, municipal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.29-9/02","Transporte rodoviário coletivo de passageiros, sob regime de fretamento, intermunicipal, nterestadual e internacional");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.29-9/03","Organização de excursões em veículos rodoviários próprios, municipal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.29-9/04","Organização de excursões em veículos rodoviários próprios, intermunicipal, interestadual e nternacional");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.29-9/99","Outros transportes rodoviários de passageiros não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.30-2/01","Transporte rodoviário de carga, exceto produtos perigosos e mudanças, municipal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.30-2/02","Transporte rodoviário de carga, exceto produtos perigosos e mudanças, intermunicipal, nterestadual e internacional");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.30-2/03","Transporte rodoviário de produtos perigosos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.30-2/04"," Transporte rodoviário de mudanças");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.40-0/00","Transporte dutoviário");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("49.50-7/00","Trens turísticos, teleféricos e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.11-4/01","Transporte marítimo de cabotagem - carga");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.11-4/02","Transporte marítimo de cabotagem - passageiros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.12-2/01","Transporte marítimo de longo curso - carga");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.12-2/02","Transporte marítimo de longo curso - passageiros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.21-1/01","Transporte por navegação interior de carga, municipal, exceto travessia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.21-1/02","Transporte por navegação interior de carga, intermunicipal, interestadual e internacional, xceto travessia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.22-0/01","Transporte por navegação interior de passageiros em linhas regulares, municipal, exceto ravessia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.22-0/02","Transporte por navegação interior de passageiros em linhas regulares, intermunicipal, nterestadual e internacional, exceto travessia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.30-1/01","Navegação de apoio marítimo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.30-1/02","Navegação de apoio portuário");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.30-1/03","Serviço de rebocadores e empurradores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.91-2/01","Transporte por navegação de travessia, municipal");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.91-2/02","Transporte por navegação de travessia intermunicipal, interestadual e internacional");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.99-8/01","Transporte aquaviário para passeios turísticos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("50.99-8/99","Outros transportes aquaviários não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("51.11-1/00","Transporte aéreo de passageiros regular");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("51.12-9/01","Serviço de táxi aéreo e locação de aeronaves com tripulação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("51.12-9/99","Outros serviços de transporte aéreo de passageiros não-regular");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("51.20-0/00","Transporte aéreo de carga");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("51.30-7/00","Transporte espacial");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.11-7/01","Armazéns gerais - emissão de warrant");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.11-7/02","Guarda-móveis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.11-7/99","Depósitos de mercadorias para terceiros, exceto armazéns gerais e guarda-móveis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.12-5/00","Carga e descarga");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.21-4/00","Concessionárias de rodovias, pontes, túneis e serviços relacionados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.22-2/00","Terminais rodoviários e ferroviários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.23-1/00","Estacionamento de veículos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.29-0/01","Serviços de apoio ao transporte por táxi, inclusive centrais de chamada");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.29-0/02","Serviços de reboque de veículos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.29-0/99","Outras atividades auxiliares dos transportes terrestres não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.31-1/01","Administração da infra-estrutura portuária");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.31-1/02","Atividades do Operador Portuário");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.31-1/03","Gestão de terminais aquaviários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.32-0/00","Atividades de agenciamento marítimo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.39-7/01","Serviços de praticagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.39-7/99","Atividades auxiliares dos transportes aquaviários não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.40-1/01","Operação dos aeroportos e campos de aterrissagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.40-1/99","Atividades auxiliares dos transportes aéreos, exceto operação dos aeroportos e campos de terrissagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.50-8/01","Comissaria de despachos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.50-8/02","Atividades de despachantes aduaneiros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.50-8/03","Agenciamento de cargas, exceto para o transporte marítimo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.50-8/04","Organização logística do transporte de carga");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("52.50-8/05","Operador de transporte multimodal - OTM");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("53.10-5/01","Atividades do Correio Nacional");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("53.10-5/02","Atividades de franqueadas e permissionárias do Correio Nacional");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("53.20-2/01","Serviços de malote não realizados pelo Correio Nacional");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("53.20-2/02","Serviços de entrega rápida");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("55.10-8/01","Hotéis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("55.10-8/02","Apart-hotéis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("55.10-8/03","Motéis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("55.90-6/01","Albergues, exceto assistenciais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("55.90-6/02","Campings");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("55.90-6/03","Pensões (alojamento)");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("55.90-6/99","Outros alojamentos não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("56.11-2/01","Restaurantes e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("56.11-2/02","Bares e outros estabelecimentos especializados em servir bebidas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("56.11-2/03","Lanchonetes, casas de chá, de sucos e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("56.12-1/00","Serviços ambulantes de alimentação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("56.20-1/01","Fornecimento de alimentos preparados preponderantemente para empresas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("56.20-1/02","Serviços de alimentação para eventos e recepções - bufê");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("56.20-1/03","Cantinas - serviços de alimentação privativos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("56.20-1/04"," Fornecimento de alimentos preparados preponderantemente para consumo domiciliar");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("58.11-5/00","Edição de livros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("58.12-3/01","Edição de jornais diários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("58.12-3/02","Edição de jornais não diários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("58.13-1/00","Edição de revistas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("58.19-1/00","Edição de cadastros, listas e de outros produtos gráficos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("58.21-2/00","Edição integrada à impressão de livros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("58.22-1/01","Edição integrada à impressão de jornais diários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("58.22-1/02","Edição integrada à impressão de jornais não diários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("58.23-9/00","Edição integrada à impressão de revistas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("58.29-8/00","Edição integrada à impressão de cadastros, listas e de outros produtos gráficos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("59.11-1/01"," Estúdios cinematográficos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("59.11-1/02","Produção de filmes para publicidade");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("59.11-1/99","Atividades de produção cinematográfica, de vídeos e de programas de televisão não specificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("59.12-0/01","Serviços de dublagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("59.12-0/02","Serviços de mixagem sonora em produção audio visual");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("59.12-0/99","Atividades de pós-produção cinematográfica, de vídeos e de programas de televisão não specificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("59.13-8/00","Distribuição cinematográfica, de vídeo e de programas de televisão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("59.14-6/00"," Atividades de exibição cinematográfica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("59.20-1/00","Atividades de gravação de som e de edição de música");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("60.10-1/00","Atividades de rádio");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("60.21-7/00","Atividades de televisão aberta");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("60.22-5/01"," Programadoras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("60.22-5/02","Atividades relacionadas à televisão por assinatura, exceto programadoras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.10-8/01","Serviços de telefonia fixa comutada - STFC");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.10-8/02","Serviços de redes de transportes de telecomunicações - SRTT");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.10-8/03","Serviços de comunicação multimídia - SCM");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.10-8/99","Serviços de telecomunicações por fio não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.20-5/01","Telefonia móvel celular");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.20-5/02"," Serviço móvel especializado - SME");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.20-5/99","Serviços de telecomunicações sem fio não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.30-2/00","Telecomunicações por satélite");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.41-8/00","Operadoras de televisão por assinatura por cabo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.42-6/00","Operadoras de televisão por assinatura por microondas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.43-4/00","Operadoras de televisão por assinatura por satélite");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.90-6/01","Provedores de acesso às redes de comunicações");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.90-6/02","Provedores de voz sobre protocolo internet - VOIP");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("61.90-6/99","Outras atividades de telecomunicações não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("62.01-5/01","Desenvolvimento de programas de computador sob encomenda");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("62.01-5/02","Web design");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("62.02-3/00","Desenvolvimento e licenciamento de programas de computador customizáveis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("62.03-1/00","Desenvolvimento e licenciamento de programas de computador não-customizáveis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("62.04-0/00","Consultoria em tecnologia da informação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("62.09-1/00","Suporte técnico, manutenção e outros serviços em tecnologia da informação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("63.11-9/00","Tratamento de dados, provedores de serviços de aplicação e serviços de hospedagem na nternet");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("63.19-4/00","Portais, provedores de conteúdo e outros serviços de informação na internet");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("63.91-7/00","Agências de notícias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("63.99-2/00","Outras atividades de prestação de serviços de informação não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.10-7/00","Banco Central");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.21-2/00","Bancos comerciais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.22-1/00","Bancos múltiplos, com carteira comercial");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.23-9/00","Caixas econômicas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.24-7/01","Bancos cooperativos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.24-7/02","Cooperativas centrais de crédito");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.24-7/03","Cooperativas de crédito mútuo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.24-7/04","Cooperativas de crédito rural");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.31-0/00","Bancos múltiplos, sem carteira comercial");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.32-8/00","Bancos de investimento");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.33-6/00","Bancos de desenvolvimento");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.34-4/00","Agências de fomento");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.35-2/01","Sociedades de crédito imobiliário");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.35-2/02"," Associações de poupança e empréstimo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.35-2/03","Companhias hipotecárias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.36-1/00","Sociedades de crédito, financiamento e investimento - financeiras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.37-9/00","Sociedades de crédito ao microempreendedor");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.38-7/01","Bancos de câmbio");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.38-7/99","Outras instituições de intermediação não-monetária não especificadas anteriormente.");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.40-9/00"," Arrendamento mercantil");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.50-6/00","Sociedades de capitalização");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.61-1/00","Holdings de instituições financeiras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.62-0/00","Holdings de instituições não-financeiras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.63-8/00","Outras sociedades de participação, exceto holdings");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.70-1/01","Fundos de investimento, exceto previdenciários e imobiliários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.70-1/02","Fundos de investimento previdenciários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.70-1/03","Fundos de investimento imobiliários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.91-3/00","Sociedades de fomento mercantil - factoring");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.92-1/00","Securitização de créditos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.93-0/00","Administração de consórcios para aquisição de bens e direitos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.99-9/01","Clubes de investimento");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.99-9/02","Sociedades de investimento");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.99-9/03","Fundo garantidor de crédito");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.99-9/04","Caixas de financiamento de corporações");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.99-9/05","Concessão de crédito pelas OSCIP");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("64.99-9/99","Outras atividades de serviços financeiros não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("65.11-1/01","Sociedade seguradora de seguros vida");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("65.11-1/02","Planos de auxílio-funeral");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("65.12-0/00","Sociedade seguradora de seguros não vida");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("65.20-1/00","Sociedade seguradora de seguros saúde");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("65.30-8/00","Resseguros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("65.41-3/00","Previdência complementar fechada");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("65.42-1/00","Previdência complementar aberta");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("65.50-2/00","Planos de saúde");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.11-8/01","Bolsa de valores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.11-8/02","Bolsa de mercadorias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.11-8/03","Bolsa de mercadorias e futuros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.11-8/04","Administração de mercados de balcão organizados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.12-6/01","Corretoras de títulos e valores mobiliários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.12-6/02","Distribuidoras de títulos e valores mobiliários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.12-6/03","Corretoras de câmbio");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.12-6/04","Corretoras de contratos de mercadorias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.12-6/05","Agentes de investimentos em aplicações financeiras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.13-4/00","Administração de cartões de crédito");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.19-3/01","Serviços de liquidação e custódia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.19-3/02","Correspondentes de instituições financeiras");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.19-3/03","Representações de bancos estrangeiros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.19-3/04","Caixas eletrônicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.19-3/05","Operadoras de cartões de débito");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.19-3/99","Outras atividades auxiliares dos serviços financeiros não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.21-5/01","Peritos e avaliadores de seguros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.21-5/02","Auditoria e consultoria atuarial");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.22-3/00","Corretores e agentes de seguros, de planos de previdência complementar e de saúde");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.29-1/00","Atividades auxiliares dos seguros, da previdência complementar e dos planos de saúde não specificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("66.30-4/00","Atividades de administração de fundos por contrato ou comissão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("68.10-2/01","Compra e venda de imóveis próprios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("68.10-2/02","Aluguel de imóveis próprios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("68.10-2/03","Loteamento de imóveis próprios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("68.21-8/01","Corretagem na compra e venda e avaliação de imóveis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("68.21-8/02","Corretagem no aluguel de imóveis");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("68.22-6/00","Gestão e administração da propriedade imobiliária");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("69.11-7/01","Serviços advocatícios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("69.11-7/02","Atividades auxiliares da justiça");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("69.11-7/03","Agente de propriedade industrial");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("69.12-5/00","Cartórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("69.20-6/01"," Atividades de contabilidade");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("69.20-6/02","Atividades de consultoria e auditoria contábil e tributária");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("70.20-4/00","Atividades de consultoria em gestão empresarial, exceto consultoria técnica específica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("71.11-1/00","Serviços de arquitetura");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("71.12-0/00","Serviços de engenharia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("71.19-7/01","Serviços de cartografia, topografia e geodésia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("71.19-7/02","Atividades de estudos geológicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("71.19-7/03","Serviços de desenho técnico relacionados à arquitetura e engenharia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("71.19-7/04","Serviços de perícia técnica relacionados à segurança do trabalho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("71.19-7/99","Atividades técnicas relacionadas à engenharia e arquitetura não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("71.20-1/00","Testes e análises técnicas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("72.10-0/00","Pesquisa e desenvolvimento experimental em ciências físicas e naturais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("72.20-7/00","Pesquisa e desenvolvimento experimental em ciências sociais e humanas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("73.11-4/00","Agências de Publicidade");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("73.12-2/00","Agenciamento de espaços para publicidade, exceto em veículos de comunicação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("73.19-0/01","Criação de estandes para feiras e exposições");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("73.19-0/02","Promoção de vendas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("73.19-0/03","Marketing direto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("73.19-0/04","Consultoria em publicidade");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("73.19-0/99","Outras atividades de publicidade não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("73.20-3/00","Pesquisas de mercado e de opinião pública");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.10-2/02","Design de interiores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.10-2/03","Design de produto");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.10-2/99","Atividades de design não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.20-0/01","Atividades de produção de fotografias, exceto aérea e submarina");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.20-0/02","Atividades de produção de fotografias aéreas e submarinas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.20-0/03","Laboratórios fotográficos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.20-0/04","Filmagem de festas e eventos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.20-0/05","Serviços de microfilmagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.90-1/01","Serviços de tradução, interpretação e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.90-1/02","Escafandria e mergulho");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.90-1/03","Serviços de agronomia e de consultoria às atividades agrícolas e pecuárias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.90-1/04","Atividades de intermediação e agenciamento de serviços e negócios em geral, exceto mobiliários");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.90-1/05","Agenciamento de profissionais para atividades esportivas, culturais e artísticas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("74.90-1/99","Outras atividades profissionais, científicas e técnicas não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("75.00-1/00","Atividades veterinárias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.11-0/00","Locação de automóveis sem condutor");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.19-5/01"," Locação de embarcações sem tripulação, exceto para fins recreativos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.19-5/02","Locação de aeronaves sem tripulação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.19-5/99","Locação de outros meios de transporte não especificados anteriormente, sem condutor");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.21-7/00","Aluguel de equipamentos recreativos e esportivos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.22-5/00","Aluguel de fitas de vídeo, DVDs e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.23-3/00"," Aluguel de objetos do vestuário, jóias e acessórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.29-2/01","Aluguel de aparelhos de jogos eletrônicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.29-2/02","Aluguel de móveis, utensílios e aparelhos de uso doméstico e pessoal; instrumentos musicai");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.29-2/03"," Aluguel de material médico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.29-2/99","Aluguel de outros objetos pessoais e domésticos não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.31-4/00","Aluguel de máquinas e equipamentos agrícolas sem operador");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.32-2/01","Aluguel de máquinas e equipamentos para construção sem operador, exceto andaimes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.32-2/02","Aluguel de andaimes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.33-1/00","Aluguel de máquinas e equipamentos para escritórios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.39-0/01","Aluguel de máquinas e equipamentos para extração de minérios e petróleo, sem operador");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.39-0/02","Aluguel de equipamentos científicos, médicos e hospitalares, sem operador");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.39-0/03","Aluguel de palcos, coberturas e outras estruturas de uso temporário, exceto andaimes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.39-0/99","Aluguel de outras máquinas e equipamentos comerciais e industriais não especificados nteriormente, sem operador");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("77.40-3/00","Gestão de ativos intangíveis não-financeiros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("78.10-8/00","Seleção e agenciamento de mão-de-obra");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("78.20-5/00","Locação de mão-de-obra temporária");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("78.30-2/00","Fornecimento e gestão de recursos humanos para terceiros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("79.11-2/00","Agências de viagens");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("79.12-1/00","Operadores turísticos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("79.90-2/00","Serviços de reservas e outros serviços de turismo não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("80.11-1/01","Atividades de vigilância e segurança privada");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("80.11-1/02","Serviços de adestramento de cães de guarda");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("80.12-9/00","Atividades de transporte de valores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("80.20-0/01","Atividades de monitoramento de sistemas de segurança eletrônico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("80.20-0/02","Outras atividades de serviços de segurança");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("80.30-7/00","Atividades de investigação particular");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("81.11-7/00","Serviços combinados para apoio a edifícios, exceto condomínios prediais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("81.12-5/00","Condomínios prediais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("81.21-4/00","Limpeza em prédios e em domicílios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("81.22-2/00","Imunização e controle de pragas urbanas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("81.29-0/00","Atividades de limpeza não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("81.30-3/00","Atividades paisagísticas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.11-3/00","Serviços combinados de escritório e apoio administrativo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.19-9/01","Fotocópias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.19-9/99","Preparação de documentos e serviços especializados de apoio administrativo não specificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.20-2/00","Atividades de teleatendimento");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.30-0/01","Serviços de organização de feiras, congressos, exposições e festas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.30-0/02","Casas de festas e eventos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.91-1/00","Atividades de cobranças e informações cadastrais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.92-0/00","Envasamento e empacotamento sob contrato");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.99-7/01","Medição de consumo de energia elétrica, gás e água");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.99-7/02","Emissão de vales-alimentação, vales-transporte e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.99-7/03","Serviços de gravação de carimbos, exceto confecção");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.99-7/04","Leiloeiros independentes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.99-7/05","Serviços de levantamento de fundos sob contrato");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.99-7/06","Casas lotéricas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.99-7/07","Salas de acesso à internet");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("82.99-7/99","Outras atividades de serviços prestados principalmente às empresas não especificadas nteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("84.11-6/00","Administração pública em geral");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("84.12-4/00","Regulação das atividades de saúde, educação, serviços culturais e outros serviços sociais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("84.13-2/00","Regulação das atividades econômicas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("84.21-3/00","Relações exteriores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("84.22-1/00","Defesa");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("84.23-0/00","Justiça");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("84.24-8/00","Segurança e ordem pública");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("84.25-6/00","Defesa Civil");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("84.30-2/00","Seguridade social obrigatória");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.11-2/00","Educação infantil - creche");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.12-1/00","Educação infantil - pré-escola");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.13-9/00","Ensino fundamental");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.20-1/00","Ensino médio");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.31-7/00","Educação superior - graduação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.32-5/00","Educação superior - graduação e pós-graduação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.33-3/00","Educação superior - pós-graduação e extensão");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.41-4/00","Educação profissional de nível técnico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.42-2/00","Educação profissional de nível tecnológico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.50-3/01","Administração de caixas escolares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.50-3/02","Atividade de apoio à educação, exceto caixas escolares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.91-1/00","Ensino de esportes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.92-9/01","Ensino de dança");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.92-9/02","Ensino de artes cênicas, exceto dança");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.92-9/03","Ensino de música");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.92-9/99","Ensino de arte e cultura não especificado anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.93-7/00"," Ensino de idiomas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.99-6/01","Formação de condutores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.99-6/02","Cursos de pilotagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.99-6/03","Treinamento em informática");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.99-6/04","Treinamento em desenvolvimento profissional e gerencial");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.99-6/05","Cursos preparatórios para concursos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("85.99-6/99","Outras atividades de ensino não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.10-1/01","Atividades de atendimento hospitalar, exceto pronto-socorro e unidades para atendimento a rgências");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.10-1/02","Atividades de atendimento em pronto-socorro e unidades hospitalares para atendimento a rgências");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.21-6/01","UTI móvel");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.21-6/02","Serviços móveis de atendimento a urgências, exceto por UTI móvel");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.22-4/00","Serviços de remoção de pacientes, exceto os serviços móveis de atendimento a urgências");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.30-5/01","Atividade médica ambulatorial com recursos para realização de procedimentos cirúrgicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.30-5/02","Atividade médica ambulatorial com recursos para realização de exames complementares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.30-5/03","Atividade médica ambulatorial restrita a consultas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.30-5/04","Atividade odontológica.");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.30-5/06","Serviços de vacinação e imunização humana");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.30-5/07","Atividades de reprodução humana assistida");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.30-5/99","Atividades de atenção ambulatorial não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/01","Laboratórios de anatomia patológica e citológica");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/02","Laboratórios clínicos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/03","Serviços de diálise e nefrologia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/04","Serviços de tomografia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/05","Serviços de diagnóstico por imagem com uso de radiação ionizante, exceto tomografia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/06","Serviços de ressonância magnética");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/07","Serviços de diagnóstico por imagem sem uso de radiação ionizante, exceto ressonância agnética");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/08","Serviços de diagnóstico por registro gráfico - ECG, EEG e outros exames análogos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/09","Serviços de diagnóstico por métodos ópticos - endoscopia e outros exames análogos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/10","Serviços de quimioterapia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/11","Serviços de radioterapia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/12","Serviços de hemoterapia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/13","Serviços de litotripcia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/14","Serviços de bancos de células e tecidos humanos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.40-2/99","Atividades de serviços de complementação diagnóstica e terapêutica não especificadas nteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.50-0/01","Atividades de enfermagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.50-0/02","Atividades de profissionais da nutrição");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.50-0/03","Atividades de psicologia e psicanálise");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.50-0/04","Atividades de fisioterapia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.50-0/05","Atividades de terapia ocupacional");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.50-0/06","Atividades de fonoaudiologia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.50-0/07","Atividades de terapia de nutrição enteral e parenteral");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.50-0/99","Atividades de profissionais da área de saúde não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.60-7/00","Atividades de apoio à gestão de saúde");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.90-9/01","Atividades de práticas integrativas e complementares em saúde humana");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.90-9/02","Atividades de banco de leite humano");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.90-9/03","Atividade de acupuntura");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.90-9/04","Atividade de podologia");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("86.90-9/99","Outras atividades de atenção à saúde humana não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("87.11-5/01","Clínicas e residências geriátricas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("87.11-5/02","Instituições de longa permanência para idosos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("87.11-5/03","Atividades de assistência a deficientes físicos, imunodeprimidos e convalescentes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("87.11-5/04","Centros de apoio a pacientes com câncer e com AIDS");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("87.11-5/05","Condomínios residenciais para idosos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("87.12-3/00","Atividades de fornecimento de infra-estrutura de apoio e assistência a paciente no domicílio");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("87.20-4/01","Atividades de centros de assistência psicossocial");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("87.20-4/99","Atividades de assistência psicossocial e à saúde a portadores de distúrbios psíquicos, eficiência mental e dependência química não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("87.30-1/01","Orfanatos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("87.30-1/02","Albergues assistenciais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("87.30-1/99","Atividades de assistência social prestadas em residências coletivas e particulares não specificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("88.00-6/00","Serviços de assistência social sem alojamento");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("90.01-9/01","Produção teatral");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("90.01-9/02","Produção musical");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("90.01-9/03","Produção de espetáculos de dança");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("90.01-9/04","Produção de espetáculos circenses, de marionetes e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("90.01-9/05","Produção de espetáculos de rodeios, vaquejadas e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("90.01-9/06","Atividades de sonorização e de iluminação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("90.01-9/99","Artes cênicas, espetáculos e atividades complementares não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("90.02-7/01","Atividades de artistas plásticos, jornalistas independentes e escritores");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("90.02-7/02","Restauração de obras-de-arte");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("90.03-5/00","Gestão de espaços para artes cênicas, espetáculos e outras atividades artísticas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("91.01-5/00","Atividades de bibliotecas e arquivos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("91.02-3/01","Atividades de museus e de exploração de lugares e prédios históricos e atrações similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("91.02-3/02","Restauração e conservação de lugares e prédios históricos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("91.03-1/00","Atividades de jardins botânicos, zoológicos, parques nacionais, reservas ecológicas e áreas e proteção ambiental");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("92.00-3/01","Casas de bingo");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("92.00-3/02","Exploração de apostas em corridas de cavalos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("92.00-3/99","Exploração de jogos de azar e apostas não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("93.11-5/00","Gestão de instalações de esportes");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("93.12-3/00","Clubes sociais, esportivos e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("93.13-1/00","Atividades de condicionamento físico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("93.19-1/01","Produção e promoção de eventos esportivos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("93.19-1/99","Outras atividades esportivas não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("93.21-2/00","Parques de diversão e parques temáticos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("93.29-8/01","Discotecas, danceterias, salões de dança e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("93.29-8/02","Exploração de boliches");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("93.29-8/03","Exploração de jogos de sinuca, bilhar e similares");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("93.29-8/04","Exploração de jogos eletrônicos recreativos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("93.29-8/99","Outras atividades de recreação e lazer não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("94.11-1/00","Atividades de organizações associativas patronais e empresariais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("94.12-0/01","Atividades de fiscalização profissional");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("94.12-0/99","Outras atividades associativas profissionais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("94.20-1/00","Atividades de organizações sindicais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("94.30-8/00","Atividades de associações de defesa de direitos sociais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("94.91-0/00","Atividades de organizações religiosas ou filosóficas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("94.92-8/00","Atividades de organizações políticas");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("94.93-6/00","Atividades de organizações associativas ligadas à cultura e à arte");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("94.99-5/00","Atividades associativas não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("95.11-8/00","Reparação e manutenção de computadores e de equipamentos periféricos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("95.12-6/00","Reparação e manutenção de equipamentos de comunicação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("95.21-5/00","Reparação e manutenção de equipamentos eletroeletrônicos de uso pessoal e doméstico");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("95.29-1/01","Reparação de calçados, bolsas e artigos de viagem");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("95.29-1/02","Chaveiros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("95.29-1/03","Reparação de relógios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("95.29-1/04","Reparação de bicicletas, triciclos e outros veículos não-motorizados");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("95.29-1/05","Reparação de artigos do mobiliário");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("95.29-1/06","Reparação de jóias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("95.29-1/99","Reparação e manutenção de outros objetos e equipamentos pessoais e domésticos não specificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.01-7/01","Lavanderias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.01-7/02","Tinturarias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.01-7/03","Toalheiros");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.02-5/01","Cabeleireiros, manicure e pedicure");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.02-5/02","Atividades de estética e outros serviços de cuidados com a beleza");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.03-3/01","Gestão e manutenção de cemitérios");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.03-3/02","Serviços de cremação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.03-3/03","Serviços de sepultamento");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.03-3/04","Serviços de funerárias");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.03-3/05","Serviços de somatoconservação");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.03-3/99","Atividades funerárias e serviços relacionados não especificados anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.09-2/02","Agências matrimoniais");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.09-2/04","Exploração de máquinas de serviços pessoais acionadas por moeda");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.09-2/05","Atividades de sauna e banhos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.09-2/06","Serviços de tatuagem e colocação de piercing");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.09-2/07","Alojamento de animais domésticos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.09-2/08","Higiene e embelezamento de animais domésticos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("96.09-2/99","Outras atividades de serviços pessoais não especificadas anteriormente");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("97.00-5/00","Serviços domésticos");
INSERT INTO cnae (cnae_codigo_cnae,cnae_descricao) VALUES ("99.00-8/00","Organismos internacionais e outras instituições extraterritoriais");

INSERT INTO tipo_contato (tcon_descricao) VALUES ("Telefone");
INSERT INTO tipo_contato (tcon_descricao) VALUES ("E-Mail");

INSERT INTO `usuario` ( `usua_nome`, `usua_ativo`, `usua_admin`, `usua_email`, `usua_senha`) VALUES ( 'admin', '1', '1', 'admin@admin.com', 'MTIzNA==');
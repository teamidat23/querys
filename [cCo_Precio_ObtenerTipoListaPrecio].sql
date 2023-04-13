--————————————————————————————————————————————————————————————————————————————                
--Creado por :Pedro Barreto (sigcomt) (17/11/2018)                
--Funcionalidad:Permite obtener el tipo de precio de lista que le corresponde al alumno segun                
--————————————————————————————————————————————————————————————————————————————                
/*                
-----------------------------------------------------------------------------                
Nro FECHA  USUARIO  DESCRIPCION                
-----------------------------------------------------------------------------                
@1 2018.11.27 jmota  precio diferenciado para CGT                
@2 2018.11.28 jmota  precio diferenciado para periodos A y Turno Tarde (A)                
@3 2018.12.07 jmota  los 02 es solo para los periodos comunes                
@4 2018.12.17 EHuillca Agrego @IdPromocion y @GrupoCodigo como parametros de entrada.                
@5 2018.12.17 EHuillca Cambio el select de Matricula a Promocion                
@6 2019.01.08 RPINEDAC orreccion grupo codigo a idgrupo                
@7 11.01.2018 Eloy Alva (Sigcomt) Agregar parametro CompaniaSocio.                
@8 21.05.2019 EHuillca Reestructuración de la lógica en la cual devuelve el tipo de cliente y adicion de los tipos(06,07,08)                 
@9 06.06.2019 EHuillca Se agrega validación para los períodos regulares y que no sean de turno tarde.                
@10 06.06.2019 EHuillca Se agrega validación cuando es diferente de carreras.                 
@11 06.06.2019 EHuillca Se comenta validacion de que solo sea captación.                
@12 07.06.2019 EHuillca Se adiciona validacion para tipo de Período 'B'.                
@13 09.07.2019 JLEO  Se adiciona validacion para tipo de condición de matricula CC And TipoServico C.                
@14 21.08.2019 JLEO  Se adiciona validacion para escuela (UnidadAcademica = 57)              
@15 26.08.2019 JLEO  Se adiciona validacion para escuela (UnidadAcademica = 57) para tipos diferenciados 09 y 10              
@16 28.08.2019 JLEO  Se adiciona validacion en tipos 09 y 10 diferentes al primer semestre              
@17 03.09.2019 JLEO  Se regulariza validación para tipo 09 y 10            
@18 09.09.2019 PUCHUYA Se agrega validacion para Division (UnidadNegocio = 2), Programa (UnidadAcademica = 58) y cantidad de cursos correspondientes          
@18 11.09.2019 PUCHUYA Se agrega parametro CompaniaSocio para validar la Compania requerida           
@19 11.09.2019 PUCHUYA Se modifica la validacion para CompaniaSocio          
@20 26.09.2019 HMora Se modifica validacion para escuela de Egresados y Secuenciales        
@21 03.10.2019 EHuillca Se agrega periodo IIIC para tipocliente 03      
@22 15.10.2019 Hmora Se agrega validacion para escuela Egresados que no estan en Academico por el Tipo de Matricula       
@23 16.10.2019 Jmota se corrige logica de if      
@24 25.10.2019 EHuillca Se modifica validación para nuevo producto CCM    
@25 07.11.2019 EHuillca Se adiciona tipocliente (12,13,14,15)    
@26 08.11.2019 Jnavia Se modifica el join de las tablas para el precio diferenciado de universidades    
@27 09.01.2020 PUchuya Se agrega logica  categoria de colegios para Corriente, tipocliente (16,17,18,19)    
@28 09.01.2020 YFlores Se modifica logica categoria de colegios para Corriente, tipocliente (16,17,18,19)    
@29 15.01.2020 YFlores Se modifica logica para optener @IdUnidadAcademica    
@30 24.02.2020 Jnavia Se modifica validación para nuevo producto CCM    
@31 27.05.2020 Jnavia Se agrega periodo IF para tipocliente 01    
@32 08.06.2020 Jnavia Se agrega periodo IF(turno tarde) para tipocliente 02    
@33 23.07.2020 Jcure Se condicion para tipocliente 20    
@34 31.08.2020 jmota Se agrega condición para IDAT    
@35 27.10.2020 Jnavia Se agrega periodo IIF para tipocliente 01 y 02    
@36 29.10.2020 Jnavia Se modifica condición del turno para TipoCliente 20    
@37 03.11.2020 Ealva Se modifica condicion para agregar TipoCliente 22    
@38 03.11.2020 Ealva Se modifica condicion para agregar TipoCliente 22 solo para el turno tarde fin de semana    
@39 12.01.2020 Hmora Se agrega condicion para egresados Zegel     
@40 12.02.2020 Hmora Se agrega condicion para egresados IDAT y otras instituciones    
@41 17.02.2021 Jnavia Se agrega periodo IJ y IIJ para tipocliente 01 y 02    
@42 04.03.2021 RSamame  Se agrega periodo en el tipo cliente 10 y 9 ('ID','IID') para los bachilleres y se esta descomenta los periodos en el tipo cliente 23 y 24 adicional se agrega los periodos 'IK','IIK','IIIK'    
@43 18.03.2021 JCure Se agrega condicion adicional al tipocliente (12,13,14,15), no debe haber tenido traslado hacia escuela    
@44 07.04.2021 Jnavia Se agrega una carrera adicional para egresados Zegel    
@45 29.04.2021 JCure Se agrega periodo IL para zegel    
@46 04.05.2021 JCure    Se agrego el producto 13958    
@47 04.05.2021 JCure Se agrega validacion porque estaba blanqueando la variable idProducto        
@48 27.05.2021 Jnavia Se agrega condición de semestre y nuevos tipos de clientes    
@49 28.05.2021 jmota Se agrega condición de precios para ccm diferenciado por turno/semestre    
@50 05.07.2021 Jnavia Se agrega el periodo IIM (CCM) al tipo cliente 08 y 31    
@51 09.07.2021 Puchuya  Se agrega condicion - precios por escalas de pensiones/tipo descuento de colegios    
@52 09.08.2021 Jnavia Se modifica condición del turno para TipoCliente 25 y 26, y se agrega WITH(NOLOCK)    
@53 16.08.2021 Jnavia Se agrega condición para el turno noche, tipo cliente 37    
@54 19.08.2021 jmota se graga nueva condicion IDAT para turno noche secuencial a partir del segundo semestre    
@55 16.09.2021 rsamame se agrega los productos en una tabla parametro y se agrega en el where ademas se coloca un top 1 ya que puede existir alumnos con 2 carreras de egresado de IES    
@56 20.09.2021 jmota para idat toda la logica debe ser por producto    
@57 07.10.2021 Jnavia Se cambia la condición para el turno noche en los tipos de clientes 29 y 30    
@58 2021.10.18 jmota se cambia nueva logica para IDAT IIIM    
@59 28.10.2021 Jnavia Se agrega periodo IIL para zegel    
@60 09.11.2021 Jnavia Se cambia la condición para el turno tarde en los tipos de clientes 25 y 26    
@61 06.12.2021 jmota se agrega nueva logica de idat ccm y cgt     
@62 27.01.2022 jcure se agrega logica zegel parecida al @60 pero ahora para secuenciales    
@63 28.01.2022 jmota se agrega logica IDAT para 2022-IO y 2022-IG    
@64 2022.02.01 hcachi Se agrega validación para Zegel (Sede Surco)     
@65 2022.02.14 puchuya Se agrega nueva condición para tipo cliente 20    
@66 2022.02.21 puchuya Se agrega nuevo tipocliente 42 - precios por escalas de pensiones (categoria referencial)    
@67 2022.03.01 jcure Se agrega la condicion de producto+curso para el tipo cliente 26    
@68 2022.03.11 jcure Se agrega la condicion de producto+curso para el tipo cliente 25    
@69 2022.03.24 rsamame Se agrega la condicion de Tipo Servicio curso para el tipo cliente 25 y 26    
@70 2022.03.25  puchuya Se agrega validación para el tipo cliente 20    
@71 2022.04.26 jmota se agrega nueva logica de precios sin los precios homologados   
@72 2022.04.29  jmota se turno agrega TARDE-NOCHE solo para CGT  
@73 2022.05.10 jmota se configura precios para captacion por 2 grupos diferentes de precios  
@74 2022.07.27 jmota Nueva logica de precios solicitado y validado por groca   
@75 2022.08.25  puchuya se modifica logica para tipocliente 01 (SURCO) y se comenta tipocliente 20 a pedido de klam  
@76 2022.10.25  ftorres Turno noche CGT dentro de CCM  
@77 2022.12.08  jmota se agrega logica de tipos de precio para escuela IDAT7  
@78 2022.12.26 jmota se configura tipo de precios para ccm y cgt  
@79 2023.01.26 illosad Se agregan tipo de precios para CARRERAS CA y se comenta validacion por producto  
@80 2023.03.16 jcure Se agrega la casuistica para la sede ITS  
@81 2023.03.23 illosad Se descomenta validacion por productos IES   
@82 2023.03.28 jcure Se coloca 47 como retorno para ITS a solicitud de JContreras   
@83 2023.03.28 LOrtiz Se agrega la casuistica para la sede CDI  
@84 2023.03.30 LOrtiz Se cambia valor para la obtención de IdSede para CDI  
@85 2023.04.12 Illosad Se agrega tipo de cliente 48 para el periodo 2023-IC de CA a pedido de KLAM  
@86 2023.04.12 jcure Se agrego el producto 13953  
*/      
CREATE FUNCTION [dbo].[cCo_Precio_ObtenerTipoListaPrecio](     
@IdMatricula INT = NULL,              
@IdPromocion INT=NULL,               
@GrupoCodigo INT= NULL,--@4              
@CompaniaSocio CHAR(8) --@7              
)            
RETURNS VARCHAR(3)              
AS         
BEGIN   
             
 --Inicio @8              
 DECLARE @retorno varchar(2) = '99',        
 @Codigo VARCHAR(5),        
 @ServicioCodigo varchar(16),         
 @Sucursal varchar(6),         
 @CodigoTurno INT ,               
 @AuxTipo VARCHAR(max) ,         
 @CodigoPeriodo VARCHAR(25),         
 @TipoCliente varchar(3) ,         
 @IdUnidadNegocio INT ,         
 @IdUnidadAcademica INT ,         
 @IdGrupo INT,        
 @pIdProducto INT,         
 @pIdActor INT,        
 @IdPromocionMat INT,         
 @IdGrupoMat INT,        
 @IdPeriodo INT,         
 @Tipo char(2) , --@9              
 @TipoCondicion char(2),         
 @TipoServicio char(1), --@13              
 @CondicionPago VARCHAR(5),  
 @IdModulo Int,  
 @OrigenInstitucion VARCHAR(100), --@25  
 @CodigoTurno2 varchar(20), --@33  
 @EsInlearning INT,  
 @IdCurricula INT,  
 @IdModuloProm INT,--@48  
    @IdTipoDescuentoColegio INT --@51  
 ,@IdSede INT --@64  
  
    DECLARE @TB_TURNO TABLE (IdTipoTurno INT, Nombre VARCHAR(100) , Tipo VARCHAR(100))  
  
 INSERT INTO @TB_TURNO  
 SELECT IdMaestroRegistro , Nombre , Disponible5     
 FROM MaestroTablaRegistro WITH(NOLOCK)  
 WHERE IdMaestroTabla = 1667   
      
 -- OBTENEMOS DATOS DE LA MATRICULA        
 SELECT @IdPromocionMat = M.IdPromocion,         
 @IdGrupoMat = M.IdGrupo,         
 @IdPeriodo = M.IdPeriodo ,         
 @Tipo = M.Tipo ,         
 @TipoCondicion = M.TipoCondicion,         
 @TipoServicio = M.TipoServicio,   
 @pIdActor = M.IdActor ,--@15        
 @CondicionPago = M.CondicionPago,  
 @IdModulo = M.IdModulo,  
 @OrigenInstitucion = MTR.Disponible1 --Inicio @25  
 FROM Matricula M WITH(NOLOCK)  
 LEFT JOIN ActorAcademica AA WITH(NOLOCK) ON AA.IdActor = M.IdActor--@26  
 LEFT JOIN MaestroTablaRegistro MTR WITH(NOLOCK) ON AA.IdInstitucion = MTR.IdMaestroRegistro -- Fin @25  --@26  
 WHERE M.IdMatricula = @IdMatricula  
  
    --inicio @51  
    SELECT @IdTipoDescuentoColegio = ISNULL(C.IdTipoDescuento,0)   
    FROM Interesado I WITH(NOLOCK)   
    INNER JOIN Colegio C WITH(NOLOCK) ON C.IdColegio = I.IdColegio   
    WHERE I.IdActor = @pIdActor  
    --fin @51  
      
 --@29 Inicio       
 -- CAMPOS DE LA PROMOCION  
 SELECT   
 @ServicioCodigo = P.ServicioCodigo,     
 @IdUnidadNegocio = P.IdUnidadNegocio,   
 @IdUnidadAcademica = P.IdUnidadAcademica ,  
 @Sucursal = S.Sucursal,    
 @CodigoPeriodo = PE.Codigo ,    
 @pIdProducto = Pr.idproducto,  
 @IdCurricula = P.IdCurricula, --@40  
 @IdModuloProm = P.IdModulo--@48  
 ,@IdSede = P.IdSede --@64  
 FROM Promocion p WITH(NOLOCK)--@52  
 INNER JOIN Periodo PE WITH(NOLOCK) ON P.IdPeriodo = PE.IdPeriodo  
 INNER JOIN Producto Pr WITH(NOLOCK) ON P.IdProducto = Pr.IdProducto   
 INNER JOIN Sede S WITH(NOLOCK) ON P.IdSede = S.IdSede    
 WHERE P.IdPromocion = ISNULL(@IdPromocionMat , @IdPromocion )   
 --@29 Fin  
  
 --@40  
 SELECT  
 @EsInlearning = EsInlearning  
 From Convalidacion WITH(NOLOCK) WHERE IdAlumno = @pIdActor AND IdPeriodoAnual = @IdPeriodo AND IdCurricula = @IdCurricula  
 --@40  
       
 -- OBTENEMOS DATOS DE LA PROMOCION GRUPO        
 SELECT         
 @CodigoTurno = T.IdTipoTurno ,                    
 @IdGrupo = PG.IdGrupo ,  
 @CodigoTurno2 = T.Codigo --@33  
 FROM Promocion P WITH(NOLOCK)--@5              
 INNER JOIN PromocionGrupo PG WITH(NOLOCK) ON P.IdPromocion = PG.IdPromocion              
 INNER JOIN Turno T WITH(NOLOCK) ON PG.IdTurno = T.IdTurno AND PG.IdGrupo= ISNULL(@IdGrupoMat,@GrupoCodigo)--@6              
 WHERE P.IdPromocion = ISNULL(@IdPromocionMat , @IdPromocion )   
 AND PG.IdGrupo = ISNULL(@IdGrupoMat,@GrupoCodigo)--@6      --@29  
  
 SET @Codigo = RTRIM(SUBSTRING( @CodigoPeriodo,CHARINDEX('-',@CodigoPeriodo,0)+1,10))          
  
 --@55  
 DECLARE @Producto AS TABLE(    
 Id  int identity,  
 idProducto INT    
 )   
 IF @Codigo IN ('ID','IID','IH','IIH') AND @CompaniaSocio = '00002500'  
 BEGIN    
  INSERT INTO @Producto(idProducto)      
  SELECT DISTINCT DATA FROM dbo.Split((select valor from parametro where nombre='DescuentoEgresadoxProducto'),',')  
 END  
 IF  @Codigo IN ('IL','IIL','IG','IIG','IK','IIK','IIIK') AND @CompaniaSocio = '00002500' --@59  
 BEGIN  
  INSERT INTO @Producto(idProducto)      
  SELECT DISTINCT DATA FROM dbo.Split((select Valor2 from parametro where nombre='DescuentoEgresadoxProducto'),',')  
 END  
 --@55     
  
 /************************************************  
  ZEGEL IPAE  
 *************************************************/     
 If(@CompaniaSocio = '00002500') --@19        
 Begin  
  --PARA ITS  
  --@80 inicio  
  IF  @IdSede = 34  
  BEGIN  
    SET @retorno = '47'--'01'    
    RETURN @retorno   
  END  
  --@80 inicio  
    
  --@64  
  -- SI EL ALUMNO PASA AL PERIODO 2022-II, ES DE CARRERA IES O EEST, Y ES DE SEXTO, SEPTIMO O OCTAVO SEMESTRE --@75  
  IF @IdSede = 7 AND @Codigo = 'II' AND @IdUnidadAcademica IN (1,57) AND @IdModulo IN(6,7,8)  
  BEGIN  
   IF EXISTS (SELECT 1 FROM Matricula M WITH(NOLOCK)   
   INNER JOIN Promocion P WITH(NOLOCK) ON M.IdPromocion=P.IdPromocion  
   INNER JOIN Periodo PE WITH(NOLOCK) ON P.IdPeriodo=PE.IdPeriodo  
   WHERE M.IdActor = @pIdActor  
   AND M.IdModulo in (6,7,8)  
   AND M.EsMatricula=1  
   AND M.Estado='N'  
   --AND M.Tipo = 'RE'  
   AND P.IdSede = 7  
   AND P.IdUnidadNegocio IN (1,57)  
   AND PE.Codigo='2022-I')  
   BEGIN  
    SET @retorno = '01'    
    RETURN @retorno   
   END  
  END  
  --@64  
    
  --@65 SI EL ALUMNO PERTENECE AL PERIODO 2022-I, ES DE CARRERA IES O EEST, ES TURNO SABADO - DOMINGO Y ES DEL TERCER SEMESTRE   
  --IF @CodigoTurno=25118 AND @Codigo = 'I' AND @IdUnidadAcademica IN (1,57) AND ISNULL(@IdModulo,@IdModuloProm) = 3 --@70 --@75  
  --BEGIN  
  -- IF EXISTS (SELECT 1 FROM Matricula M WITH(NOLOCK)   
  -- INNER JOIN Promocion P WITH(NOLOCK) ON M.IdPromocion=P.IdPromocion  
  -- INNER JOIN Periodo PE WITH(NOLOCK) ON P.IdPeriodo=PE.IdPeriodo  
  -- INNER JOIN PromocionGrupo PG WITH(NOLOCK) ON P.IdPromocion = PG.IdPromocion AND M.IdGrupo= PG.IdGrupo             
  -- INNER JOIN Turno T WITH(NOLOCK) ON PG.IdTurno = T.IdTurno  
  -- WHERE M.IdActor = @pIdActor  
  -- AND M.Estado='N'  
  -- AND M.EsMatricula=1  
  -- AND M.IdModulo=2  
  -- --AND M.Tipo = 'RE'  
  -- AND P.IdUnidadNegocio IN (1,57)  
  -- AND PE.Codigo='2021-II'  
  -- AND T.IdTipoTurno = @CodigoTurno)  
  -- BEGIN  
  --  SET @retorno = '20'    
  --  RETURN @retorno   
  -- END  
  --END  
  --@65  
  
  -- inicio @62 SI EL ALUMNO PERTENECE AL PERIODO REGULAR I,II,IB,IIB,IF,IIF,IJ,IIJ, ES CARRERA Y ESCUELA, NO ES TURNO NOCHE Y L-M-V, Y ES SECUENCIAL Y ES PRODUCTO  
  IF @Codigo IN('I','II','IB','IIB','IF','IIF','IJ','IIJ') AND @IdUnidadAcademica IN (1,57) AND @CodigoTurno NOT IN(24,29243)   
  AND ISNULL(@IdModulo,@IdModuloProm) > 1 AND (@TipoServicio='P' or @TipoServicio='M' or @TipoServicio='C')--@68 --@69  
  BEGIN              
   SET @retorno= '25'              
   RETURN @retorno              
  END  
  
  -- SI EL ALUMNO PERTENECE AL PERIODO REGULAR I,II,IB,IIB,IF,IIF,IJ,IIJ, ES CARRERA Y ESCUELA, ES TURNO NOCHE Y L-M-V, Y ES SECUENCIAL Y ES PRODUCTO o PRODUCTO+CURSO   
  IF @Codigo IN('I','II','IB','IIB','IF','IIF','IJ','IIJ') AND @IdUnidadAcademica IN (1,57) AND @CodigoTurno IN(24,29243)   
  AND ISNULL(@IdModulo,@IdModuloProm) > 1 AND (@TipoServicio='P' or @TipoServicio='M'or @TipoServicio='C')--@67 --@69  
  BEGIN              
   SET @retorno= '26'              
   RETURN @retorno              
  END  
  -- fin @62  
  
  --Inicio @33  
  IF @IdUnidadNegocio=1 and @CodigoPeriodo IN('2021-IA') AND ISNULL(@IdModulo,@IdModuloProm) > 1  --@37--@48  
  BEGIN --@38  
   IF @CodigoTurno IN (1712,25118)--@37  
   BEGIN   
    SET @retorno= '22'              
    RETURN @retorno   
   END  
   ELSE  
   BEGIN  
    SET @retorno= '04'              
    RETURN @retorno   
   END       
  END --@38  
  
  IF (@CodigoTurno=25118 OR @CodigoTurno=976) AND (@CodigoTurno2 LIKE 'SD40%' OR @CodigoTurno2='TTN40') AND ISNULL(@IdModulo,@IdModuloProm) > 1 --@36--@48  
  BEGIN  
   SET @retorno = '20'    
   RETURN @retorno    
  END  
  --Fin @33  
  
  --Inicio @43  
  IF not exists(  
  SELECT 1 FROM trasladosede ts WITH(NOLOCK)--@52  
  inner join periodo p WITH(NOLOCK) on ts.idperiodoanterior = p.idperiodo--@52  
  WHERE ts.IdAlumno = @pIdActor  
  and ts.IdUnidadAcademica = 57   
  and p.idunidadnegocio = 1 and p.IdUnidadAcademica <> 57 )  
  BEGIN  
     --Inicio @25  
     IF @OrigenInstitucion = 'ALTO_LIMA'  
     BEGIN  
      SET @retorno = '12'  
      RETURN @retorno  
     END  
  
     IF @OrigenInstitucion = 'BAJO_LIMA'  
     BEGIN  
      SET @retorno = '13'  
      RETURN @retorno  
     END  
  
     IF @OrigenInstitucion = 'ALTO_PROVINCIA'  
     BEGIN  
      SET @retorno = '14'  
      RETURN @retorno  
     END  
  
     IF @OrigenInstitucion = 'BAJO_PROVINCIA'  
     BEGIN  
      SET @retorno = '15'  
      RETURN @retorno  
     END   
       --Fin @25  
  END--FIN @43  
  
  --Incio @15            
  If @IdUnidadAcademica = 57         
  Begin        
  --@20             
   If (ISNULL(@pIdActor,''))<>''--@47  
   Begin  
     --Toma el producto de la carrera de la que Egreso el Alumno        
     set @pIdProducto = (SELECT TOP 1 C.IdProducto     --@55  
     FROM Egresados E WITH(NOLOCK)      
     INNER JOIN Curricula C WITH(NOLOCK) ON E.IdCurricula=C.IdCurricula      
     WHERE E.IdAlumno=@pIdActor      
     AND E.IdUnidadAcademica=1  
     AND C.IdProducto IN (select idproducto from @Producto)--@55  
      )            
   end  
  
   If @pIdProducto = 10557  AND @Codigo IN ('ID','IID','IH','IIH')    --@42       
   Begin            
    SET @retorno = '10'    --@17          
    RETURN @retorno             
   End            
      
   If @pIdProducto = 10597 Or @pIdProducto = 10598  AND @Codigo IN ('ID','IID','IH','IIH')   --@42           
   Begin            
    SET @retorno = '09'    --@17          
    RETURN @retorno             
   End  
   --@39  
   If @pIdProducto in (10568, 10562 , 10563, 12543 , 12544 ,12585 , 12586 , 12587 , 12589 , 12591, 12592, 12583  
   ,13958, 13953) --@46 --@86  
   AND @Codigo IN ('IL','IIL','IG','IIG','IK','IIK','IIIK')--@42--@44 --@45--@59  
   Begin  
    SET @retorno = '23'              
    RETURN @retorno          
   END  
   --@39  
  
   --@40  
   IF @EsInlearning = 1 AND @Tipo = 'CI' AND @Codigo IN ('IL','IIL','IG','IIG','IK','IIK','IIIK')--@42    --@45--@59  
   BEGIN   
    SET @retorno = '23'  
    RETURN @retorno  
   END  
   IF @EsInlearning = 0 AND @Tipo = 'CI' AND @Codigo IN ('IL','IIL','IG','IIG','IK','IIK','IIIK')--@42    --@45--@59  
   BEGIN   
    SET @retorno = '24'  
    RETURN @retorno  
   END  
   --@40  
  
  end     
  Else     
  Begin    
   IF exists(SELECT  1 FROM Gupta.dbo.Egresados E WITH(NOLOCK)--@52  
   INNER JOIN Gupta.dbo.PERSONAS PE WITH(NOLOCK) ON  E.CD_CLTE = PE.CD_PERS--@52  
   INNER JOIN Actor A WITH(NOLOCK) ON A.NumeroIdentidad = PE.NR_DOCUIDEN--@52  
   INNER JOIN Matricula M WITH(NOLOCK) ON M.IdActor = A.IdActor--@52  
   WHERE M.IdMatricula = @IdMatricula) and @Tipo='CI' and @IdModulo > 1  --@23    
   BEGIN     
    SET @retorno = '09'    --@22          
    RETURN @retorno        
   END        
  End    
    
  --Inicio @10              
  IF @IdUnidadNegocio != 1 And @CompaniaSocio = '00002500'  --@18        
  BEGIN              
   SET @retorno = '01'              
   RETURN @retorno              
  END                
              
  --@Inicio 13              
  If @TipoCondicion = 'CC' And @TipoServicio = 'C' And @CompaniaSocio = '00002500' AND ISNULL(@IdModulo,@IdModuloProm) > 1 --@18--@48  
  Begin              
   SET @retorno= '01'              
   RETURN @retorno               
  End         
  --@Fin 13              
  --Fin @10        
          
  --Inicio @9              
  -- SI EL ALUMNO NO ES TURNO TARDE Y NOCHE, CARRERA Y PERTENECE AL PERIODO REGULAR I,II,IB,IIB,IF          
  IF @CodigoTurno NOT IN(976,24) AND @IdUnidadAcademica In (1,57) AND @Codigo IN('I','II','IB','IIB','IF','IIF','IJ','IIJ') AND ISNULL(@IdModulo,@IdModuloProm) > 1-- si no es turno tarde--@12  --@14 --@31--@35--@41--@48--@53  
  BEGIN         
   SET @retorno= '01'              
   RETURN @retorno              
  END              
  --Fin @9               
               
  -- SI EL ALUMNO ES TURNO TARDE,CARRERA Y PERTENECE AL PERIODO REGULAR I,II,IB,IIB              
  IF @CodigoTurno = 976 AND @IdUnidadAcademica In (1,57) AND @Codigo IN('I','II','IB','IIB','IF','IIF','IJ','IIJ') AND ISNULL(@IdModulo,@IdModuloProm) > 1-- si es turno tarde--@12  --@14 --@32--@35--@41--@48  
  BEGIN              
   SET @retorno= '02'              
   RETURN @retorno              
  END              
    
  --Inicio @53  
  -- SI EL ALUMNO ES TURNO NOCHE, CARRERA Y ESCUELA, Y PERTENECE AL PERIODO REGULAR I,II,IB,IIB,IF,IIF,IJ,IIJ  
  IF @CodigoTurno = 24 AND @IdUnidadAcademica In (1,57) AND @Codigo IN('I','II','IB','IIB') AND ISNULL(@IdModulo,@IdModuloProm) > 1  
  BEGIN              
   SET @retorno= '37'              
   RETURN @retorno              
  END              
  --Fin @53  
  
  --@1 SI EL ALUMNO PERTENECE AL PERIODOTIPO C - CGT- CAPTACION Y SECUENCIAL               
  IF @Codigo IN('IC','IIC','IIIC') AND @IdUnidadAcademica In (1,57) --AND @IdPeriodo ISNULL AND @Tipo = 'MA' --@9 Solo Captaci?n.--@11  --@14 --@21 --@24  
  BEGIN              
   SET @retorno= '03'               
   RETURN @retorno               
  END               
               
  --@2 SI EL ALUMNO PERTENECE AL PERIODOTIPO A              
  IF @Codigo IN('IA','IIA') AND @IdUnidadAcademica In (1,57) AND @CodigoTurno <> 976 AND ISNULL(@IdModulo,@IdModuloProm) > 1-- si no es turno tarde  --@14--@48       
  BEGIN              
   SET @retorno= '04'              
   RETURN @retorno              
  END               
               
  --@2 SI EL ALUMNO PERTENECE AL PERIODOTIPO A Y TURNO TARDE               
  IF @Codigo IN('IA','IIA') AND @IdUnidadAcademica In (1,57) AND @CodigoTurno = 976 AND ISNULL(@IdModulo,@IdModuloProm) > 1-- si es turno tarde  --@14--@48  
  BEGIN              
   SET @retorno= '05'              
   RETURN @retorno              
  END               
               
  --SI EL ALUMNO PERTENECE AL PERIODOTIPO D               
  IF @Codigo IN('ID','IID') AND @IdUnidadAcademica In (1,57) AND @CodigoTurno <> 976-- si no es turno tarde  --@14            
  BEGIN              
   SET @retorno= '06'               
   RETURN @retorno               
  END          
          
  --SI EL ALUMNO PERTENECE AL PERIODOTIPO D Y TURNO TARDE               
  IF @Codigo IN('ID','IID') AND @IdUnidadAcademica In (1,57) AND @CodigoTurno = 976-- sies turno tarde  --@14            
  BEGIN              
   SET @retorno= '07'               
   RETURN @retorno              
  END              
              
  --SI EL ALUMNO PERTENECE A CCM              
  IF @Codigo IN('IE','IIE','IIIE','IIM') AND @IdUnidadAcademica In (1,57) AND ISNULL(@IdModulo,@IdModuloProm) > 1 -- CCM --@14 --@24 --@30--@48--@50  
  BEGIN              
   SET @retorno= '08'              
   RETURN @retorno              
  END              
  --Fin @8  
  
  --Inicio @48              
  -- SI EL ALUMNO PERTENECE AL PERIODO REGULAR I,II,IB,IIB,IF,IIF,IJ,IIJ, ES CARRERA Y ESCUELA, NO ES TURNO NOCHE Y L-M-V, Y ES I SEMESTRE  
  IF @Codigo IN('I','II','IB','IIB','IF','IIF','IJ','IIJ') AND @IdUnidadAcademica IN (1,57) AND @CodigoTurno NOT IN(24,29243) AND ISNULL(@IdModulo,@IdModuloProm) = 1--@52--@60  
  BEGIN              
   SET @retorno= '25'              
   RETURN @retorno              
  END  
  
  -- SI EL ALUMNO PERTENECE AL PERIODO REGULAR I,II,IB,IIB,IF,IIF,IJ,IIJ, ES CARRERA Y ESCUELA, ES TURNO NOCHE Y L-M-V, Y ES I SEMESTRE  
  IF @Codigo IN('I','II','IB','IIB','IF','IIF','IJ','IIJ') AND @IdUnidadAcademica IN (1,57) AND @CodigoTurno IN(24,29243) AND ISNULL(@IdModulo,@IdModuloProm) = 1--@52--@60  
  BEGIN              
   SET @retorno= '26'              
   RETURN @retorno              
  END  
  
  -- SI EL ALUMNO PERTENECE AL PERIODO REGULAR IA,IIA, ES CARRERA Y ESCUELA, NO ES TURNO NOCHE, Y ES I SEMESTRE  
  IF @Codigo IN('IA','IIA') AND @IdUnidadAcademica IN (1,57) AND @CodigoTurno NOT IN(24) AND ISNULL(@IdModulo,@IdModuloProm) = 1 --@57  
  BEGIN              
   SET @retorno= '29'              
   RETURN @retorno              
  END  
  
  -- SI EL ALUMNO PERTENECE AL PERIODO REGULAR IA,IIA, ES CARRERA Y ESCUELA, ES TURNO NOCHE, Y ES I SEMESTRE  
  IF @Codigo IN('IA','IIA') AND @IdUnidadAcademica IN (1,57) AND @CodigoTurno IN(24) AND ISNULL(@IdModulo,@IdModuloProm) = 1 --@57  
  BEGIN              
   SET @retorno= '30'              
   RETURN @retorno              
  END  
  
  --SI EL ALUMNO PERTENECE A CCM, ES CARRERA Y ESCUELA, Y ES I SEMESTRE  
  IF @Codigo IN('IE','IIE','IIIE','IIM') AND @IdUnidadAcademica In (1,57) AND ISNULL(@IdModulo,@IdModuloProm) = 1 --@50  
  BEGIN              
   SET @retorno= '31'              
   RETURN @retorno              
  END   
  --Fin @48  
 End   
  
 /************************************************  
   CORRIENTE ALTERNA  
 *************************************************/   
 DECLARE @SedeParametro INT= (SELECT Valor2 FROM Parametro WITH(NOLOCK) WHERE Nombre='SeparacionDeSpringMatricula' AND Activo=1) --@83 --@84  
 If(@CompaniaSocio = '00002600') --@19        
 Begin  
  -- Inicio @83  
  --PARA CDI    
  IF  @IdSede = @SedeParametro    
  BEGIN    
   SET @retorno = '01'      
   RETURN @retorno     
  END   
  -- Fin @83  
  --@85 Inicio  
  IF @CodigoPeriodo='2023-IC'  
  BEGIN  
   SET @retorno= '48'          
   RETURN @retorno    
  END  
  --@85 Fin  
  --@18 Inicio        
  --SI EL ALUMNO PERTENECE A LA DIVISION (EXTENSION), PROGRAMA (PEAC) y si la cantidad de cursos es diferente a 3, el retorno es 11         
  IF  @IdUnidadNegocio = 2 AND @IdUnidadAcademica = 58  AND @TipoCondicion = 'CC' AND @TipoServicio = 'C' AND @CondicionPago = 'C'        
  BEGIN          
   DECLARE @CantCurso INT = 0        
   SELECT @CantCurso = COUNT(IdCurso) FROM AlumnoCurso WITH (NOLOCK)         
   where IdMatricula = @IdMatricula  and isnull(IdPromocion,0) <> 0 and isnull(IdGrupo,0) <> 0        
     
   IF @CantCurso = 3         
   BEGIN        
    SET @retorno= '11'          
    RETURN @retorno         
   END   
  END   
  
  --Inicio @27 --@51  
  -------------------precios por escala de pensiones de colegios  
  IF  @IdUnidadNegocio = 1 AND @IdUnidadAcademica IN (1, 59) AND @pIdProducto in (339,340)    --@79  --@81  
  BEGIN    
            ------Categoria 1  
            IF @IdTipoDescuentoColegio = 25781  
            BEGIN   
                SET @retorno= '33'   
    RETURN @retorno  
            END  
  
            ------Categoria 2  
            IF @IdTipoDescuentoColegio = 25782  
            BEGIN   
                SET @retorno= '34'   
    RETURN @retorno  
            END  
  
            ------Categoria 3  
            IF @IdTipoDescuentoColegio = 25783  
            BEGIN   
                SET @retorno= '35'   
    RETURN @retorno  
            END  
     
            ------Categoria 4  
            IF @IdTipoDescuentoColegio = 25784  
            BEGIN   
                SET @retorno= '36'   
    RETURN @retorno  
            END  
  
   ------Categoria 5 - referencial --@66  
            IF @IdTipoDescuentoColegio = 29424  
            BEGIN   
                SET @retorno= '43'   
    RETURN @retorno  
            END  
     
  END         
     --Fin @27 --@51  
     
  SET @retorno= '01'       
  RETURN @retorno          
  --@18 Fin  
     
 END       
       
     
  /************************************************  
   IDAT  
   01 CPT  
   59 CGT  
   60 CCM  
   57 ESCUELA  
   TIPO TURNO= IdMaestroTABLA = 1667  
   PARA MATRICULAS POR CURSO EN MAT DEBE SER PRECIO DE PRODUCTO Y EN CUOTAS TIPOCLIENTE 01   
   PERO LA LOGICA SE PONE EN EL SP QUE CREA LAS CUOTAS.  
  *************************************************/   
 IF(@CompaniaSocio = '00002700') --@34         
 BEGIN  
  
  /************************************************  
  57 ESCUELA   
  *************************************************/   
  
  IF @IdUnidadAcademica In (57) -- @77  
  BEGIN  
   -- Turno noche      
   IF EXISTS (SELECT IdTipoTurno FROM @TB_TURNO WHERE IdTipoTurno = @CodigoTurno AND Tipo = 'NOCTURNO')   
   BEGIN              
    SET @retorno= '44'              
    RETURN @retorno           
   END   
   -- Otros Turnos     
   IF NOT EXISTS (SELECT IdTipoTurno FROM @TB_TURNO WHERE IdTipoTurno = @CodigoTurno AND Tipo = 'NOCTURNO')   
   BEGIN              
    SET @retorno= '46'              
    RETURN @retorno              
   END      
  END  
  
  /************************************************  
   60 CCM  
  *************************************************/   
  IF @IdUnidadAcademica In (60) -- @71 @74  
  BEGIN  
  
   -- otros inicios -- Turno noche      
   IF EXISTS (SELECT IdTipoTurno FROM @TB_TURNO WHERE IdTipoTurno = @CodigoTurno AND Tipo = 'NOCTURNO')   
   BEGIN              
    SET @retorno= '44'              
    RETURN @retorno              
   END   
     
   -- otros inicios -- Otros Turnos     
   IF NOT EXISTS (SELECT IdTipoTurno FROM @TB_TURNO WHERE IdTipoTurno = @CodigoTurno AND Tipo = 'NOCTURNO')   
   BEGIN              
    SET @retorno= '46'              
    RETURN @retorno              
   END          
  
  END  
     
  /************************************************  
   59 CGT  
   Alumnos de carrera CGT, turno Noche (cobranzas indica que solo debe ser turno noche y debe ser el 03)   
  *************************************************/   
  IF @IdUnidadAcademica In (59)  -- @71  @74  
  BEGIN   
    -- es para todos porque solo secuenciales se estan matriculando en CGT  
    SET @retorno= '45'               
    RETURN @retorno              
  END                        
          
  /************************************************  
   01 CPT  
  *************************************************/   
  IF @IdUnidadAcademica In (1)  
  BEGIN  
   --@54 Alumnos de Carrera CPT, a partir del sdo. Semestre turno noche en secuencial    
   IF @CodigoTurno = 24 AND @IdModuloProm > 1    
   BEGIN             
    SET @retorno= '38'              
    RETURN @retorno              
   END   
         
   -- SI EL ALUMNO ES TURNO TARDE Y EN CPT     
   IF @Codigo IN('IB','IIB')        
   BEGIN             
    SET @retorno= '01'              
    RETURN @retorno              
   END   
    
   -- SI EL ALUMNO NO ES TURNO TARDE Y EN CPT     
   IF @CodigoTurno != 976 AND @Codigo IN('IA','IIA','IH','IIH')          
   BEGIN              
    SET @retorno= '04'              
    RETURN @retorno              
   END   
    
   -- SI EL ALUMNO ES TURNO TARDE Y EN CPT     
   IF @CodigoTurno = 976 AND @Codigo IN('IA','IIA','IH','IIH')          
   BEGIN           
    SET @retorno= '05'              
    RETURN @retorno              
   END   
  
   -- SI EL ALUMNO NO ES TURNO TARDE Y EN CPT     
   IF @CodigoTurno != 976 AND @Codigo IN('I','II')          
   BEGIN              
    SET @retorno= '01'              
    RETURN @retorno              
   END   
    
   -- SI EL ALUMNO ES TURNO TARDE Y EN CPT     
   IF @CodigoTurno = 976 AND @Codigo IN('I','II')                
   BEGIN              
    SET @retorno= '02'              
    RETURN @retorno              
   END  
  END  
    
  /************************************************  
   FC  
  *************************************************/  
  
  -- SI EL ALUMNO ES FC     
  IF @IdUnidadNegocio != 1   
  BEGIN              
   SET @retorno= '01'           
   RETURN @retorno              
  END    
  
 END  
  
 RETURN @retorno              
END  
  



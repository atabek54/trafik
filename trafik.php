



<?php

// 0- Anguler ile bu servise bağlanırken verilmesi gereken izinler

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Credentials: true");
header('Access-Control-Allow-Headers: X-gelen_dataed-With');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT');

// 1-DB Bağlantısı gerekli PHP


$host = '45.84.205.102';
$user = 'u113559345_ThGvg';
$pass = 'CUMxQXe1le';
$data = 'u113559345_vz3vz';

try {
$pdo = new PDO('mysql:host='.$host.';dbname='.$data.';charset=utf8', $user, $pass);
} catch (PDOException $e) {
print "Error!: " . $e->getMessage();
}

// $url = './sifremi_unuttum.json';
$gelen_json = file_get_contents("php://input");
$gelen_data = json_decode($gelen_json);
$operation_type = $gelen_data->operation_type;
$service_type = $gelen_data->service_type;

date_default_timezone_set('Europe/Istanbul');
$currentDate = date('Y-m-d H:i:s');
$startOfDay = date('Y-m-d 00:00:00');



$web_type = $_GET['type'];

/*------------ ERROR START -----------*/

$error_list = array(

  "basarili" => array(
    'httpCode' => 200,
    'description' => 'The request was successfully processed by the server and the result was generated.'
  ),

  "mail_gonderildi" => array(
    'httpCode' => 201,
    'description' => 'Your password has been sent to your email.'
  ),
  "kayit_basarili" => array(
    'httpCode' => 202,
    'description' => 'A verification link has been sent to your email account.'
  ),

  "gecersiz" => array(
    'httpCode' => 400,
    'description' => 'Invalid username or password.'
  ),

  "kayit_hatasi" => array(
    'httpCode' => 401,
    'description' => 'An error occurred during registration.'
  ),

  "kayit_type_id_hatasi" => array(
    'httpCode' => 402,
    'description' => 'Type_id error occurred during registration.'
  ),

  "kayitli_email" => array(
    'httpCode' => 403,
    'description' => 'This email address has already registered.'
  ),

  "kategori_getir" => array(
    'httpCode' => 404,
    'description' => 'Failed to fetch categories.'
  ),

  "follow" => array(
    'httpCode' => 405,
    'description' => 'Failed to follow.'
  ),

  "il" => array(
    'httpCode' => 406,
    'description' => 'İller getirilirken bir hata oluştu.'
  ),

  "ilce" => array(
    'httpCode' => 407,
    'description' => 'İlceler getirilirken bir hata oluştu.'
  ),

  "mail_gonderilemedi" => array(
    'httpCode' => 408,
    'description' => 'Failed to send mail.'
  ),

  "gecersiz_email" => array(
    'httpCode' => 408,
    'description' => 'Invalid email address.'
  ),

  "anasayfa_bos" => array(
    'httpCode' => 409,
    'description' => 'There are no posts to display on the homepage.'
  ),

  "yorum_yapan_yok" => array(
    'httpCode' => 410,
    'description' => 'Yorum yapan yok.'
  ),

  "post_paylas" => array(
    'httpCode' => 411,
    'description' => 'Yorum yapan yok.'
  ),

  "yorum_paylas" => array(
    'httpCode' => 412,
    'description' => 'Yorum paylaşılamadı.'
  ),

  "enler_bos" => array(
    'httpCode' => 413,
    'description' => 'Enler getirilemedi.'
  ),
  "like" => array(
    'httpCode' => 414,
    'description' => 'Like hatalı.'
  ),
  "dislike" => array(
    'httpCode' => 415,
    'description' => 'Dislike hatalı.'
  ),

  "gezgin_bos" => array(
    'httpCode' => 416,
    'description' => 'Gezenlerde gösterilecek gönderi yok.'
  ),

  "imkanlar_bos" => array(
    'httpCode' => 417,
    'description' => 'Imkanlarda gösterilecek gönderi yok.'
  ),

  "gezginekle_bos" => array(
    'httpCode' => 418,
    'description' => 'Check-in yapılamadı.'
  ),

  "kurumsal_hesap_onay_bekliyor" => array(
    'httpCode' => 419,
    'description' => 'Your account is under approval.'
  ),

  "sunucu" => array(
    'httpCode' => 500,
    'description' => 'Kullanıcının gönderdiği kod sunucu tarafından başarılı bir şekilde işlenemediği, beklenmeyen hatanın oluştuğunu belirtir.'
  )
);

/*------------- ERROR END ------------  */

function createOutput($error, $errorMsg, $response_data)
{
  $output_array = array(
    'error' => $error,
    'errorMsg' => $errorMsg,
    'data' => $response_data
  );
  return $output_array;
}

//Login
if ($operation_type == "select" && $service_type == "cities") {

  
  $stmt = $pdo->prepare("SELECT * FROM iller");

  $sonuc = $stmt->execute();
  $row = $stmt->fetchAll(PDO::FETCH_ASSOC);
  print json_encode($row);

 




} 
else if($operation_type == "insert" && $service_type == "register"){
  
 




  $phone = $gelen_data->phone;


  $stmt = $pdo->prepare("SELECT tu.*,i.sehiradi from trafik_user tu INNER JOIN iller i on i.id=tu.plaka where phone=$phone");


  $sonuc = $stmt->execute();
  $row = $stmt->fetchAll(PDO::FETCH_ASSOC);
  if($row!=[]){
    $row = ['Kullanıcı kayıtlı'];
//Kullanıcı kayıtlı 
    

  }
  else{
   // Kullanıcı kayıtlı değil kaydet
   

   $name = $gelen_data->name;
   $plaka = $gelen_data->plaka;
   $uuid = $gelen_data->uuid;



  $stmt = $pdo->prepare("INSERT INTO `u113559345_vz3vz`.`trafik_user`(`name`, `phone`, `plaka`, `uuid`) VALUES ('$name', '$phone', '$plaka', '$uuid')");
  $sonuc = $stmt->execute();
  

  $lastInsertId=$pdo->lastInsertId();
 
  $stmt = $pdo->prepare("SELECT tu.*,i.sehiradi from trafik_user tu INNER JOIN iller i on i.id=tu.plaka where tu.uuid='$uuid'");
  $sonuc = $stmt->execute();
  $row = $stmt->fetchAll(PDO::FETCH_ASSOC);
  print json_encode($row);




    
  }

 

}

else if($operation_type == "select" && $service_type == "login"){
  $phone = $gelen_data->phone;
  $stmt = $pdo->prepare("SELECT tu.*,i.sehiradi from trafik_user tu INNER JOIN iller i on i.id=tu.plaka WHERE phone='$phone'");
  $sonuc = $stmt->execute();
  $row = $stmt->fetchAll(PDO::FETCH_ASSOC);
 
if($row!=[]){
  print json_encode($row);
}else{
  // Kullanıcı kayıtlı değil

    $row = ['Kullanıcı kayıtlı değil'];
 
      print json_encode($row);
}
}
else if($operation_type == "select" && $service_type == "warnings"){
  $sehiradi = $gelen_data->sehiradi;

  $stmt = $pdo->prepare("SELECT w.id,w.typeId,w.description,w.userId,w.createdAt,wt.title,wt.iconUrl,i.sehiradi  FROM `warnings`  w
  INNER JOIN warning_types wt on wt.id=w.typeId
  INNER JOIN	trafik_user tu on tu.uuid=w.userId
  INNER JOIN iller i on i.id=tu.plaka
  
  
  where i.sehiradi='sakarya' and createdAt>='$startOfDay' order by w.createdAt desc");
  $sonuc = $stmt->execute();
  $row = $stmt->fetchAll(PDO::FETCH_ASSOC);
  if($row!=[]){
    print json_encode($row);
  }else{
    // Kullanıcı kayıtlı değil
  
      $row = ['İlan bulunamadı.'];
   
        print json_encode($row);
  }

}

else if($operation_type=="insert"&&$service_type=="add_warning"){
  $typeId = $gelen_data->typeId;
  $description = $gelen_data->description;
  $userId = $gelen_data->userId;
  $createdAt = $currentDate;
  $stmt = $pdo->prepare("INSERT INTO `u113559345_vz3vz`.`warnings`(`typeId`, `description`, `userId`, `createdAt`) VALUES ('$typeId', '$description', '$userId', '$createdAt')");
  $sonuc = $stmt->execute();
  $lastInsertId=$pdo->lastInsertId();
  print $lastInsertId;
  $stmt = $pdo->prepare("SELECT w.id,w.typeId,w.description,w.userId,w.createdAt,wt.title,wt.iconUrl,i.sehiradi  FROM `warnings`  w
  INNER JOIN warning_types wt on wt.id=w.typeId
  INNER JOIN	trafik_user tu on tu.id=w.userId
  INNER JOIN iller i on i.id=tu.plaka
  
  
  where w.id=$lastInsertId");
  $sonuc = $stmt->execute();
  $row = $stmt->fetchAll(PDO::FETCH_ASSOC);
  print json_encode($row);
  
  if($row!=[]){
    print json_encode($row);
  }else{
    // Kullanıcı kayıtlı değil
  
      $row = ['İlan eklenemedi'];
   
        print json_encode($row);
  }


}









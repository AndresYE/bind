;Escuela Politécnica Nacional
;Tema: Servicios de Red Basado en Contenedores
;Autor: Andrés Lenin Yazán Endara
;Servicio: DNS
;Archivo: db.master.TIC2023.com 
;Función: Archivo de Zonas Directas DNS


;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	ns1.TIC2023.com. root.TIC2023.com. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
;@	IN	NS	localhost.
;@	IN	A	127.0.0.1
;@	IN	AAAA	::1

;Información del Servidor DNS 
@		IN      NS      ns1.TIC2023.com.


;Dirección IP del Servidor DNS 
ns1.TIC2023.com.     IN      A       192.168.0.2
;Dirección IP del Servidor DHCP 
dhcp.TIC2023.com.     IN      A      192.168.0.3
;Dirección IP del Servidor FTP
ftp.TIC2023.com.     IN      A       192.168.0.4
;Dirección IP del Servidor WEB
www.TIC2023.com.     IN      A       192.168.0.5
;Dirección IP del Servidor VoIP 
voip.TIC2023.com.     IN      A       192.168.0.6

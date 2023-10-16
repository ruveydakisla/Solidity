// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KiralamaKontrati{
    struct Kiraci{
        address kiraciAdres;
        string ad;
        string adresBilgisi;
    }
    struct Mulk{
        address sahipAdres;
        string ad;
        string adresBilgisi;
    }
    struct Kiralama{
        address kiraciAdres;
        address mulkAdres;
        uint256 kiraBaslangicTarihi;
        uint256 kiraBitisTArihi;
    }

    mapping(address=>Kiraci) public kiracilar;
    mapping (address=>Mulk) public  mulkler;
    Kiralama[] public kiralamalar;


    event YeniKiraciEklendi (address indexed kiraciAdres,string ad);
    event YeniMulkEklendi (address indexed mulkAdres,string ad);
    event KiralamaOlusturuldu(address indexed kiraciAdres, address indexed mulkAdres,uint256 kiraBaslangicTarihi,uint256 kiraBitisTarihi);
    event KiralamaSonlandirildi(address indexed kiraciAdres,address indexed mulkAdres);

    modifier SadeceKiraciSahibi(address kiraciAdres){
        require(msg.sender==kiraciAdres,"Kiraci degilsiniz");
        _;
    }
    modifier  SadeceMulkSahibi(address mulkAdres){
        require(msg.sender==mulkler[mulkAdres].sahipAdres,"Mulk sahibi degilsiniz.");
        _;
    }
    function KiraciEkle(string memory ad,string memory adresBilgisi) public {
        kiracilar[msg.sender]=Kiraci(msg.sender,ad,adresBilgisi);
        emit YeniKiraciEklendi(msg.sender, ad);
    }
    function MulkEkle(string memory ad, string memory adresBilgisi) public{
        mulkler[msg.sender]=Mulk(msg.sender,ad,adresBilgisi);
        emit YeniMulkEklendi(msg.sender, ad);
    }
    function KiralamaOlustur(address kiraciAdres,address mulkAdres,uint256 kiralamaBaslangicTarihi,uint256 kiralamaBitisTarihi) public SadeceKiraciSahibi(kiraciAdres) SadeceMulkSahibi(mulkAdres){
        kiralamalar.push(Kiralama(kiraciAdres,mulkAdres,kiralamaBaslangicTarihi,kiralamaBitisTarihi));
        emit KiralamaOlusturuldu(kiraciAdres, mulkAdres, kiralamaBaslangicTarihi, kiralamaBitisTarihi);
    }

    function KiralamaSonlandir(uint256 kiraIndeks) public{
        require(kiraIndeks<kiralamalar.length,"Gecersiz kira endeksi");
        Kiralama storage kira=kiralamalar[kiraIndeks];
        require(msg.sender==kira.kiraciAdres || msg.sender==mulkler[kira.mulkAdres].sahipAdres,"Bu kirayi sonlandirma yetkiniz yok.");
        delete kiralamalar[kiraIndeks];
        emit KiralamaSonlandirildi(kira.kiraciAdres, kira.mulkAdres);

    }
}

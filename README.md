

### 2.Hafta 1.Odev
---

## Table of contents[![](./docs/img/pin.svg)](#table-of-contents)

1. [Aciklama](#aciklama)
2. [Not](#not)
3. [Usage](#usage)

---

#### Aciklama: [![](./docs/img/pin.svg)](#aciklama)

#### 1.Kisim

Kullanici `app` dizinindeki uygulamayi docker ile calistirmak istemektedir. Ona yardimci olacak bir script yazin.

1. Kullanici uygulamasini icin build edilen image icin `image name` ve `image tag` verebilmeli. Bu zorunlu 
   bir parametre olmali, kullanici bu iki parametreden birini vermedi mi script `ERROR` verip sonlanmalidir.
   (Not: Projenin Dockerfile'ini yazmayi unutmayiniz !!!)

2. Kullanici kendi yerelinde bu docker image'i calistirabilmelidir, image'i calistirken `memory` ve `cpu` limitleri
   tanimlayabilmeli. Herhangi bir limit belirtilmedigi surece default olarak hicbir limit belirtilmemelidir, yani 
   limitsiz calismalidir.

3. Kullaniciya iki tane image registery sunulmali `dockerhub` ve `gitlab image registery`, kullanici istedigi registery'e image pushlayabilmeli.

4. Kullanicinin bazi veritabani ihtiyaci olabilir, kullaniya `mysql` ve `mongo` servislerini ayaga kaldirabilecegi bir secenek sunulmali.
   (Not: bu template servisler icin `docker-compose` kullanin. Docker compose dosyasi icinde `memory` ve `cpu` limitlemesi yapiniz.)


`Kullanici`: Bu scripti kullanan yazilimci, developer, gelistirici.

---

##### ODEV ACIKLAMASI ####

Yazilan script'in 3 tane modu olmali bu 3 mod birbirinden bagimsizdir.

**1. Mod:** *Image Build Modu*

   Kullanici burada image build edebilmeli:

```shell
   Example:
        docker_dev_tools.sh --mode build --image-name example_image --image-tag v1 --registery example_registery     
    
   Not-1: "--registery" parametresi zorunlu olmamali cunku kullanici sadece image'i kendi yerelinde tutmak istiyor olabilir.  
   Not-2: Kullanici registery vermisse image bu registery'e pushlanmali
   
   Opsiyonel Parametreler:
    - registery
   
   Zorunlu Parametreler:
   - mode
   - image-name
   - image-tag
```

**2. Mod:** *Image Deploy Modu*

Kullanici burada build ettigi image'i calistirabilmelidir.

```shell
    Example: 
        docker_dev_tools.sh --mode deploy --image-name example_image --image-tag v1 --container-name example_container --memory "1g" --cpu "1.0"
    
    Zorunlu Parametreler:
    - mode
    - image-name
    - image tag
    
    Opsiyonel Parametreler:
    - container-name
    - memory
    - cpu 
          
```

**3. Mod:** *Template App Calistirma*

Bu mod icin kullanici kendisine sunulan template uygulamayi calistirabilmeli, sadece iki secenek sunulmali.
Kullanici bu seceneklerde olmayan bir uygulama ismi girerse hata verilmelidir. Bu template uygulamalarin `docker-compose` 
dosyalarini yazmalisiniz.

```shell
    Example: 
        docker_dev_tools.sh --mode tempate --application-name mysql
    
    Zorunlu Parametreler:
    - mode
    - application-name
    
    Not: mysql farkli, mongo farkli docker-compose dosyalari icinde olmali.
```




---

#### Not: [![](./docs/img/pin.svg)](#not)

- Siz istediginiz her hangi bir dilde yazilmis farkli bir projeyi kullanabilirsiniz.
- Zorunlu olan herhangi bir parametre verilmedigi zaman script `ERROR` verip durmalidir.
---


#### Example Usage: [![](./docs/img/pin.svg)](#usage)


```shell

$ docker_dev_tools.sh

Usage:
    --mode              Select mode <build|deploy|template> 
    --image-name        Docker image name
    --image-tag         Docker image tag
    --memory            Container memory limit
    --cpu               Container cpu limit
    --container-name    Container name
    --registery         DocherHub or GitLab Image registery
    --application-name  Run mysql or mongo server
```


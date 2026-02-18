# bore4

**Un wrapper intelligent pour [bore](https://github.com/ekzhang/bore-cli) avec fallback IPv4 automatique.**

Crée des tunnels TCP vers `bore.pub` avec support automatique du basculement IPv4 quand IPv6 est indisponible. Idéal pour partager des services locaux à travers le réseau sans se soucier de votre connectivité.

---

## ✨ Fonctionnalités

- 🔍 **Détection automatique IPv6** - Teste la connectivité IPv6 vers bore.pub
- 🔄 **Fallback IPv4** - Bascule automatiquement sur IPv4 en cas d'indisponibilité d'IPv6
- 💾 **Cache d'IP** - Mémorise les adresses IP résolues pour accélérer les lancements suivants
- 🔁 **Retry automatique** - Relance bore automatiquement en cas d'échec (configurable)
- ⚙️ **Configuration personnalisée** - Support d'un fichier de config optionnel (`~/.bore4rc`)
- 🎨 **Logs coloriés** - Messages clairs avec codes couleur pour les infos/avertissements/erreurs
- 🛡️ **Validation du port** - Vérifie la validité du port avant de créer le tunnel
- 🔎 **Détection du processus** - Identifie quel service écoute sur le port spécifié

---

## 📋 Prérequis

- `bash` (4.0+)
- `bore` CLI installée
- `lsof` (pour détecter les processus)
- `dig` ou `nslookup` (pour la résolution DNS)
- `nc` (netcat, pour tester la connectivité)

---

## 🚀 Installation

```bash
git clone https://github.com/YOURUSER/bore4.git
cd bore4
bash install.sh
```

L'installateur place le script dans `/usr/local/bin/bore4` et le rend exécutable.

---

## 📖 Utilisation

```bash
# Syntaxe basique
bore4 <port_local> [options bore]

# Exemples
bore4 3000                              # Tunnel simple sur le port 3000
bore4 8080 --secret mysecret           # Avec authentification
bore4 5000 --local-host 127.0.0.1      # Avec options bore additionnelles
```

### Que fait bore4 ?

1. ✅ Valide que le port fourni est un nombre entre 1-65535
2. ✅ Vérifie qu'un service écoute bien sur ce port local
3. ✅ Détecte le processus qui utilise le port (affiche le PID et le nom)
4. ✅ Teste la connectivité IPv6 vers bore.pub:7835
5. ✅ Crée le tunnel :
   - Via IPv6 si disponible (plus rapide)
   - Via IPv4 avec cache et retry automatiques si IPv6 indisponible

---

## ⚙️ Configuration

Créez `~/.bore4rc` pour personnaliser le comportement :

```bash
# ~/.bore4rc
HOST="bore.pub"          # Serveur bore (par défaut: bore.pub)
TIMEOUT=2                # Timeout pour les tests (par défaut: 2s)
RETRIES=2                # Nombre de tentatives (par défaut: 2)
```

---

## 📁 Fichiers

- `bore4` - Script principal (shell script)
- `install.sh` - Script d'installation
- `README.md` - Cette documentation

---

## 🔧 Architecture

Le script fonctionne en plusieurs étapes :

| Phase | Description |
|-------|------------|
| **Validation** | Vérification du port et des services locaux |
| **Détection IPv6** | Test de connectivité IPv6 vers bore.pub:7835 |
| **Exécution** | Lancement du tunnel bore (IPv6 ou IPv4) |
| **Fallback IPv4** | Résolution DNS avec caching pour IPv4 |
| **Retry** | Relances automatiques en cas d'échec |

---

## 🐛 Troubleshooting

### "No service is listening on localhost:3000"
```bash
# Vérifiez que votre service est bien démarré
# Listez les ports en écoute:
lsof -nP -iTCP -sTCP:LISTEN
```

### "Failed to resolve IPv4"
```bash
# Testez votre résolution DNS:
dig bore.pub
nslookup bore.pub

# Videz le cache si nécessaire:
rm ~/.bore4_cache
```

### IPv6 indisponible
bore4 se règle automatiquement sur IPv4 - c'est normal ! Aucune action requise.

---

## 📝 Logs et débogage

Les messages affichent des codes couleur :
- 🔹 `[INFO]` - Informations de progression
- ⚠️ `[WARN]` - Avertissements (fallback IPv4, retries)
- ❌ `[ERR]` - Erreurs bloquantes

---

## 📄 Licence

MIT - Libre d'utilisation

---

**🔗 Ressources**
- [bore CLI](https://github.com/ekzhang/bore-cli)
- [bore.pub](https://bore.pub)

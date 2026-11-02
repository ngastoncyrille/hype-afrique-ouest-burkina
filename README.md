# Modélisation HYPE de trois bassins du Burkina Faso

Mise en place et calage du modèle hydrologique HYPE sur trois bassins : le Mouhoun, le Nakanbé et la Sirba. Les sous-modèles sont extraits du modèle régional West Africa HYPE 1.2 du SMHI.

Auteur : NEBIE Gaston Cyrille, ingénieur hydrologue. Travaux réalisés en 2025.

## Objectif

Disposer, pour chaque bassin, d'un modèle HYPE autonome, plus léger que le modèle régional. Il doit pouvoir être recalé sur les débits observés locaux. C'est un préalable à des usages de prévision et d'analyse de scénarios à l'échelle nationale.

## Contenu

| Dossier | Sous-bassins | Période simulée | Calage |
|---|---|---|---|
| `mouhoun/` | 130 | 1979-2020 (critères à partir de 1981) | Calage exploratoire achevé, paramètres dans `resultats_calage/` |
| `nakanbe/` | 42 | 1998-2017 (critères à partir de 2000) | Calage lancé, à poursuivre |
| `sirba/` | 53 | 1998-2010 (critères à partir de 2000) | Calage lancé, à poursuivre |

Chaque dossier contient les fichiers de configuration HYPE :
- `info.txt` : périodes, sorties, critères de calage ;
- `par.txt` et `optpar.txt` : paramètres et bornes de calage ;
- `GeoData.txt` et `GeoClass.txt` : sous-bassins, classes de sol et d'occupation ;
- `ForcKey.txt` : liens entre sous-bassins et séries de forçage ;
- `gis/subbasins.shp` : contours des sous-bassins.

Le script `scripts/data_extraction.R` extrait un sous-modèle du modèle régional avec le package HYPEtools. Il sélectionne les sous-bassins, puis filtre les débits observés et les forçages (pluie, températures).

## Méthode de calage

- Algorithme DEMC, Differential Evolution Markov Chain (ter Braak, 2006), intégré à HYPE. Les populations de paramètres évoluent en chaînes parallèles.
- Critère : KGE modifié (MKG) sur les débits journaliers simulés et observés.
- Paramètres calés : vitesse et amortissement de l'écoulement en rivière (`rivvel`, `damp`), paramètres des sols par classe (`wcfc`, `wcwp`, `wcep`, `mperc1`, `mperc2`, `srrcs`), évapotranspiration (`cevp`, `kc`, `lp`), correction des forçages (`preccorr`, `cevpcorr`, `pcelevadd`).

## État des travaux

Le calage du Mouhoun est un premier essai exploratoire de 500 itérations. Les performances obtenues ne sont pas encore satisfaisantes, et le travail est à poursuivre. Les pistes sont les suivantes :
- allonger le calage ;
- caler par sous-bassin jaugé plutôt qu'à l'échelle régionale ;
- contrôler la qualité des débits observés et le traitement des retenues.

Les calages du Nakanbé et de la Sirba ont été lancés mais pas menés à terme.

## Ce qui n'est pas dans ce dépôt

- L'exécutable HYPE. Il est téléchargeable sur le site du SMHI : <https://hypeweb.smhi.se>.
- Les séries d'observation et de forçage (`Pobs`, `Tobs`, `TMINobs`, `TMAXobs`, `Qobs`) et les sorties de simulation, trop volumineuses. Elles sont disponibles sur demande.

## Sources

- Modèle West Africa HYPE 1.2, SMHI (Swedish Meteorological and Hydrological Institute).
- Lindström G., Pers C., Rosberg J., Strömqvist J., Arheimer B. (2010). Development and testing of the HYPE (Hydrological Predictions for the Environment) water quality model for different spatial scales. *Hydrology Research*, 41(3-4), 295-319.
- ter Braak C. J. F. (2006). A Markov Chain Monte Carlo version of the genetic algorithm Differential Evolution. *Statistics and Computing*, 16, 239-249.

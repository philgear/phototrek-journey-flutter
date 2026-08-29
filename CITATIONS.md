# 📚 Academic Citations & Scientific Bibliography

This document provides formal citations and references for the mathematical algorithms, astronomical calculations, student privacy protocols, citizen science frameworks, and positive psychology principles integrated into the **PhotoTrek** ecosystem.

---

## 1. Combinatorial Optimization & Vehicle Routing (VRPTW)

1. **Dantzig, G. B., & Ramser, J. H. (1959).** *The Truck Dispatching Problem*. *Management Science*, 6(1), 80–91.  
   *Foundational formulation introducing the Vehicle Routing Problem (VRP).*
2. **Solomon, M. M. (1987).** *Algorithms for the Vehicle Routing and Scheduling Problems with Time Window Constraints*. *Operations Research*, 35(2), 254–265.  
   *Canonical formulation of the Vehicle Routing Problem with Time Windows (VRPTW) used in our route planning solvers.*
3. **Perron, L., & Didier, F. (2024).** *Google Optimization Tools (OR-Tools)*. Google AI Research.  
   *Constraint programming and routing library utilized in `expedition_vrp_optimizer.ipynb`.*
4. **Lin, S., & Kernighan, B. W. (1973).** *An Effective Heuristic Algorithm for the Traveling-Salesman Problem*. *Operations Research*, 21(2), 498–516.  
   *Theoretical basis for the 2-Opt and nearest-neighbor heuristics implemented in pure Dart (`VrpOptimizer.dart`).*
5. **Clarke, G., & Wright, J. W. (1964).** *Scheduling of Vehicles from a Central Depot to a Number of Delivery Points*. *Operations Research*, 12(4), 568–581.

---

## 2. Solar Astronomy, Geodesy & Celestial Mechanics

1. **Meeus, J. (1998).** *Astronomical Algorithms* (2nd ed.). Willmann-Bell, Richmond, VA.  
   *Gold-standard treatise for calculating solar coordinates, obliquity, equation of time, solar declination, and azimuth/elevation angles.*
2. **Reda, I., & Andreas, A. (2004).** *Solar Position Algorithm for Solar Radiation Applications*. *Solar Energy*, 76(5), 577–589. National Renewable Energy Laboratory (NREL).  
   *Benchmark SPA algorithm providing step-by-step validation for trigonometric solar vector calculations.*
3. **Sinnott, R. W. (1984).** *Virtues of the Haversine*. *Sky and Telescope*, 68(2), 159.  
   *Great-circle distance formulation over the WGS84 ellipsoid implemented across our GIS tooling and Dart engines.*
4. **National Geospatial-Intelligence Agency (NGA). (2014).** *Department of Defense World Geodetic System 1984 (WGS 84)*. Technical Report NGA.STND.0036_1.0.0_WGS84.

---

## 3. Citizen Science, Crowd-Sourced Research & Micro-Grants

1. **Lintott, C. J., Schawinski, K., Slosar, A., Land, K., Bamford, S., Thomas, D., et al. (2008).** *Galaxy Zoo: Morphologies derived from visual inspection of galaxies from the Sloan Digital Sky Survey*. *Monthly Notices of the Royal Astronomical Society*, 389(3), 1179–1189.  
   *Demonstrates the empirical validity of crowd-sourced citizen science classifications for astronomical research.*
2. **Simpson, R., Page, K. R., & De Roure, D. (2014).** *Zooniverse: Observing the World's Largest Citizen Science Platform*. *Proceedings of the 23rd International Conference on World Wide Web (WWW '14 Companion)*, 1049–1054. ACM.  
   *Architectural and volunteer engagement model underlying our student micro-grant calculation engine.*
3. **Bonney, R., Cooper, C. B., Dickinson, J., Kelling, S., Phillips, T., Rosenberg, K. V., & Shirk, J. (2009).** *Citizen Science: A Developing Tool for Expanding Science Knowledge and Scientific Literacy*. *BioScience*, 59(11), 977–984.  
   *Evidence for STEM learning gains and scientific agency when K-12 students participate in real-world data collection.*
4. **National Academies of Sciences, Engineering, and Medicine. (2018).** *Learning Through Citizen Science: Enhancing Projects by Design*. Washington, DC: The National Academies Press.

---

## 4. Student Data Privacy & Legal Compliance

1. **Federal Trade Commission (FTC). (1998).** *Children's Online Privacy Protection Act (COPPA)*. 15 U.S.C. §§ 6501–6506; 16 C.F.R. Part 312.  
   *Regulatory standard governing our zero-PII client-side architecture (no names, emails, biometrics, or tracking cookies).*
2. **U.S. Department of Education. (1974).** *Family Educational Rights and Privacy Act (FERPA)*. 20 U.S.C. § 1232g; 34 CFR Part 99.  
   *Federal compliance standard for protecting student educational records and rosters during off-campus school activities.*

---

## 5. Positive Psychology, Awe, Flow & Educational Agency

1. **Seligman, M. E. P. (2011).** *Flourish: A Visionary New Understanding of Happiness and Well-being*. Free Press, New York.  
   *Introduces the PERMA framework (Positive Emotion, Engagement, Relationships, Meaning, Accomplishment).*
2. **Csikszentmihalyi, M. (1990).** *Flow: The Psychology of Optimal Experience*. Harper & Row, New York.  
   *Defines optimal psychological flow states occurring when challenges precisely match expedition skill levels.*
3. **Keltner, D., & Haidt, J. (2003).** *Approaching awe, a moral, spiritual, and aesthetic emotion*. *Cognition and Emotion*, 17(2), 297–314.  
   *Scientific exploration of awe, the "small-self" effect, and default mode network (DMN) down-regulation during natural immersion.*
4. **Fredrickson, B. L. (2001).** *The role of positive emotions in positive psychology: The broaden-and-build theory of positive emotions*. *American Psychologist*, 56(3), 218–226.  
   *Theoretical model demonstrating how awe and curiosity broaden cognitive visual search and build social resilience.*
5. **Bandura, A. (1997).** *Self-Efficacy: The Exercise of Control*. W. H. Freeman, New York.  
   *Foundational theory on how student mastery of real tasks (e.g., funding a bus via research) creates durable self-efficacy.*
6. **Dweck, C. S. (2006).** *Mindset: The New Psychology of Success*. Random House, New York.  
   *Framework for replacing math/algorithm intimidation with iterative growth mindset computational discovery.*
7. **Edmondson, A. (1999).** *Psychological Safety and Learning Behavior in Work Teams*. *Administrative Science Quarterly*, 44(2), 350–383.  
   *Principles of transparent communication and psychological safety for parent trust and student cohort cohesion.*

---

## 6. Accessibility & Web Standards

1. **World Wide Web Consortium (W3C). (2018).** *Web Content Accessibility Guidelines (WCAG) 2.1*. W3C Recommendation.  
   *Compliance standards for 4.5:1 / 7:1 color contrast, focus-visible indicators (Criterion 2.4.7), and motion reduction preferences (`prefers-reduced-motion`).*

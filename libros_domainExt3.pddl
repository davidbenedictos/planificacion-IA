(define (domain planificacion-libros)
  (:requirements :adl :typing :existential-preconditions :fluents)
  
  (:types
    libro mes
  )

  (:functions
        (numero_mes ?mes - mes) ; a cada mes li assignem un número 1-12                           
        (planificado_para ?libro - libro) ; mes en que es planteja llegir un llibre
        (paginas_leidas ?mes - mes) ; pàgines llegides en el mes dit
        (paginas_libro ?libro - libro) ; num pàgines d'un llibre
  )

  (:predicates
    (leido ?libro - libro)
    (prerequisito ?libro - libro ?pre - libro)
    (paralelo ?libro1 - libro ?libro2 - libro)
    (quiere_leer ?libro - libro)
  )

  (:action querer_prerequisito
    :parameters (?libro - libro ?pre - libro)
    :precondition (and 
                    (not (quiere_leer ?pre))
                    (prerequisito ?libro ?pre)
                    (quiere_leer ?libro)
                  )
    :effect (and 
              (quiere_leer ?pre) 
            )
  )

  (:action querer_paralelo
    :parameters (?libro - libro ?par - libro)
    :precondition (and 
                    (not (quiere_leer ?par))
                    (paralelo ?libro ?par)
                    (quiere_leer ?libro)
                  )
    :effect (and 
              (quiere_leer ?par) 
            )
  )

  (:action leer
  :parameters (?libro - libro ?mes - mes)
  :precondition (and 
                  (quiere_leer ?libro)
                  (not (leido ?libro))
                  (<= (+ (paginas_leidas ?mes) (paginas_libro ?libro)) 800)
                  ; prerequisitos
                  (or 
                    (not (exists (?x - libro) (prerequisito ?libro ?x)))
                    (forall (?pre - libro) 
                      (or 
                        (not (prerequisito ?libro ?pre))
                        ; que el prerequisit s'hagi llegit abans
                        (and (prerequisito ?libro ?pre) (leido ?pre) (< (planificado_para ?pre) (numero_mes ?mes)))
                      )
                    )
                  )
                  ; paralelos
                  (forall (?par - libro)
                    (or
                      (not (paralelo ?libro ?par))
                      (and 
                        (paralelo ?libro ?par)
                        (leido ?par)
                        (or 
                          ; que es llegeixi el mes abans, el mateix mes, o un mes després
                          (= (planificado_para ?par) (numero_mes ?mes)) ; mateix mes
                          (= (planificado_para ?par) (- (numero_mes ?mes) 1)) ; Mes anterior
                          (= (planificado_para ?par) (+ (numero_mes ?mes) 1)) ; Mes següent
                        )
                      )
                    )
                  )
                )
  :effect (and 
            (leido ?libro) 
            (increase (paginas_leidas ?mes) (paginas_libro ?libro)) ; actualitzem pàgines llegides
            (assign (planificado_para ?libro) (numero_mes ?mes)) ; planifiquem lectura per al mes correcte
          )
  )
)
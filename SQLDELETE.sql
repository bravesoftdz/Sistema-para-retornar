DELETE FROM VEF_EMP_TMOVSERITENS WHERE (BDCODATVM >= 23683 AND BDCODATVM <= 23920);
DELETE FROM VEF_EMP_TMOVSERITENS WHERE BDCODATVM = 78705;
DELETE FROM VEF_EMP_TMOVSERITENS WHERE BDCODATVM = 79439;

DELETE FROM VEF_BASE_TCONFATVMSN WHERE (BDCODATVM >= 23683 AND BDCODATVM <= 23920);
DELETE FROM VEF_BASE_TCONFATVMSN WHERE BDCODATVM = 78705;
DELETE FROM VEF_BASE_TCONFATVMSN WHERE BDCODATVM = 79439;

DELETE FROM VFIN_ESC_TRPSEMITIDO WHERE (BDCODATVM >= 23683 AND BDCODATVM <= 23920);
DELETE FROM VFIN_ESC_TRPSEMITIDO WHERE BDCODATVM = 78705;
DELETE FROM VFIN_ESC_TRPSEMITIDO WHERE BDCODATVM = 79439;

DELETE FROM VFIN_ESC_TSERVICO_GEST WHERE (BDCODATVM >= 23683 AND BDCODATVM <= 23920);
DELETE FROM VFIN_ESC_TSERVICO_GEST WHERE BDCODATVM = 78705;
DELETE FROM VFIN_ESC_TSERVICO_GEST WHERE BDCODATVM = 79439;

DELETE FROM TATVMUNICIPAL WHERE BDCODCID = 4991;
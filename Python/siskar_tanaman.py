import streamlit as st

def evaluate_rule(condition, facts):
    def evaluate_single_condition(cond):
        key, value = cond.split(' = ')
        return facts.get(key) == value

    # Handle parentheses
    while '(' in condition:
        start = condition.rfind('(')
        end = condition.find(')', start)
        sub_condition = condition[start+1:end]
        result = evaluate_rule(sub_condition, facts)
        condition = condition[:start] + str(result) + condition[end+1:]

    # Evaluate AND conditions
    if 'AND' in condition:
        conditions = condition.split(' AND ')
        for cond in conditions:
            if cond == 'False':
                return False
            if cond != 'True' and not evaluate_single_condition(cond):
                return False
        return True

    # Evaluate OR conditions
    if 'OR' in condition:
        conditions = condition.split(' OR ')
        for cond in conditions:
            if cond == 'True':
                return True
            if cond != 'False' and evaluate_single_condition(cond):
                return True
        return False

    return evaluate_single_condition(condition)

def forward_chaining(rules, facts):
    inferred = facts.copy()
    changes = True

    while changes:
        changes = False
        for rule in rules:
            if not evaluate_rule(rule['antecedent'], inferred):
                continue

            consequent_key, consequent_value = rule['consequent'].split(' = ')
            if inferred.get(consequent_key) != consequent_value:
                inferred[consequent_key] = consequent_value
                changes = True

    return inferred

def main():
    rules = [
        {'antecedent': 'bonggol = kering OR (bonggol = normal AND akar = sehat)', 'consequent': 'kondisi tanaman = baik'},
        {'antecedent': 'bonggol = kering OR (bonggol = normal AND akar = busuk)', 'consequent': 'kondisi tanaman = tidak baik'},
        {'antecedent': 'bonggol = busuk AND daun = layu', 'consequent': 'kondisi tanaman = tidak baik'},
        {'antecedent': 'bonggol = busuk AND daun = tidak layu AND akar = sehat', 'consequent': 'kondisi tanaman = baik'},
        {'antecedent': 'bonggol = busuk AND daun = tidak layu AND akar = busuk', 'consequent': 'kondisi tanaman = tidak baik'},
        {'antecedent': '(pencahayaan = kurang AND suhu = panas) OR suhu = normal', 'consequent': 'lingkungan = baik'},
        {'antecedent': 'pencahayaan = kurang AND suhu = lembab', 'consequent': 'lingkungan = tidak baik'},
        {'antecedent': '(pencahayaan = cukup AND suhu = panas) OR suhu = normal', 'consequent': 'lingkungan = baik'},
        {'antecedent': 'pencahayaan = cukup AND suhu = lembab', 'consequent': 'lingkungan = tidak baik'},
        {'antecedent': '(pencahayaan = berlebih AND suhu = panas) OR suhu = normal', 'consequent': 'lingkungan = baik'},
        {'antecedent': 'pencahayaan = berlebih AND suhu = lembab', 'consequent': 'lingkungan = tidak baik'},
        {'antecedent': '(kondisi tanaman = baik AND sanitasi = sering) OR (sanitasi = tidak rutin AND lingkungan = baik)', 'consequent': 'keputusan = sehat'},
        {'antecedent': '(kondisi tanaman = baik AND sanitasi = sering) OR (sanitasi = tidak rutin AND lingkungan = tidak baik)', 'consequent': 'keputusan = terkena hama'},
        {'antecedent': 'kondisi tanaman = baik AND sanitasi = rutin', 'consequent': 'keputusan = sehat'},
        {'antecedent': '(kondisi tanaman = tidak baik AND sanitasi = sering) OR sanitasi = tidak rutin', 'consequent': 'keputusan = terkena hama'},
        {'antecedent': 'kondisi tanaman = tidak baik AND sanitasi = rutin AND lingkungan = baik', 'consequent': 'keputusan = sehat'},
        {'antecedent': 'kondisi tanaman = tidak baik AND sanitasi = rutin AND lingkungan = tidak baik', 'consequent': 'keputusan = terkena hama'}
    ]

    st.title('SISTEM PAKAR DETEKSI HAMA PADA TANAMAN ADENIUM')

    target_facts = {
        'bonggol': st.radio("Masukkan kondisi bonggol:", ('kering', 'normal', 'busuk')),
        'daun': st.radio("Masukkan kondisi daun:", ('layu', 'tidak layu')),
        'akar': st.radio("Masukkan kondisi akar:", ('sehat', 'busuk')),
        'sanitasi': st.radio("Masukkan kondisi sanitasi:", ('sering', 'rutin', 'tidak rutin')),
        'pencahayaan': st.radio("Masukkan kondisi pencahayaan:", ('kurang', 'cukup', 'berlebih')),
        'suhu': st.radio("Masukkan kondisi suhu:", ('panas', 'normal', 'lembab'))
    }

    if st.button('Evaluate'):
        inferred_facts = forward_chaining(rules, target_facts)

        st.subheader("Hasil evaluasi:")
        for fact, value in inferred_facts.items():
            st.write(f"{fact}: {value}")

if __name__ == "__main__":
    main()

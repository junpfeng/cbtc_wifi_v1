# 目标：将文件中的干扰功率，依次筛选出�?# 文件格式�?不包括注释内�?每行�?列为所需要的内容

# 打开文件


def file_parse(file_path):

    ans = list()
    with open(file_path) as fp:
        text = fp.readlines()
        for line in text:
            if line[0] == "#":
                continue
            str_list = line.split()
            str_ans = float(str_list[5])  # �������float
            ans.append(str_ans)
    return ans
# 扫描文件内容

# 检测每行第六列的内容，直到最后一�?

if __name__ == "__main__":

    ans = file_parse("1.txt")
    for item in ans:
        print(item)

